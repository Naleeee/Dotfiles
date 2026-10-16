#!/bin/bash

# Give the current worktree its own Postgres database, cloned from the main checkout's one.
# Usage: WtDb.sh          clone the db, point apps-v2/api/.env at it, add a lazysql connection
#        WtDb.sh --drop   undo it (run by the worktrunk pre-remove hook)
set -eu

lazysql=~/.config/lazysql/config.toml
root=$(git rev-parse --show-toplevel)
primary=$(git worktree list --porcelain | head -1 | sed 's/^worktree //')
env="$root/apps-v2/api/.env"

db_url() { sed -nE 's/^DATABASE_URL="?([^"]*)"?$/\1/p' "$1"; }
db_name() { printf '%s' "$1" | sed -E 's#.*/([^/?]+).*#\1#'; }

if [ "${1:-}" = "--drop" ] && [ ! -f "$env" ]; then exit 0; fi

url=$(db_url "$env")
template=$(db_name "$(db_url "$primary/apps-v2/api/.env")")
current=$(db_name "$url")

if [[ "$url" =~ ^postgresql://([^:]+):([^@]+)@([^:/]+):([0-9]+)/ ]]; then
  export PGUSER=${BASH_REMATCH[1]} PGPASSWORD=${BASH_REMATCH[2]} PGHOST=${BASH_REMATCH[3]} PGPORT=${BASH_REMATCH[4]}
else
  echo "cannot parse DATABASE_URL in $env" >&2
  exit 1
fi

if [ "${1:-}" = "--drop" ]; then
  [ "$current" != "$template" ] || exit 0
  dropdb --force --if-exists "$current"
  awk -v db="$current" -v q="'" '
    function flush() { if (buf != "" && index(buf, "DBName = " q db q) == 0) printf "%s", buf }
    /^\[\[database\]\]/ { flush(); buf = "" }
    { buf = buf $0 "\n" }
    END { flush() }
  ' "$lazysql" > "$lazysql.tmp" && mv "$lazysql.tmp" "$lazysql"
  perl -0pi -e 's/\n+\z/\n/' "$lazysql"
  echo "dropped $current"
  exit 0
fi

if [ "$current" != "$template" ]; then
  echo "already on $current"
  exit 0
fi

branch=$(git branch --show-current)
key=$(printf '%s' "$branch" | grep -oE '[A-Za-z]+-[0-9]+' | head -1 | tr '[:upper:]-' '[:lower:]_')
key=${key:-$(printf '%s' "$branch" | tr -c '[:alnum:]\n' '_')}
new="${template}_${key}"

createdb "$new"
pg_dump "$template" | psql -q -v ON_ERROR_STOP=1 "$new" >/dev/null
sed -i '' -E "s#(^DATABASE_URL=.*/)${template}(\"?)\$#\1${new}\2#" "$env"
cat >> "$lazysql" <<TOML

[[database]]
Name = '$(printf '%s' "$key" | tr '[:lower:]_' '[:upper:]-')'
URL = '${url%/$template}/$new?sslmode=disable'
Provider = 'postgres'
DBName = '$new'
TOML
echo "$new ready; run 'bun run migrate' in apps-v2/api"
