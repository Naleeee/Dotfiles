# Worktrees

One git worktree per ticket or PR review, one tmux window per worktree, one tmux
session per project. Built on [Worktrunk](https://worktrunk.dev/) and
[sesh](https://github.com/joshmedeski/sesh).

---

## Layout

```
App
  1 Develop   shell on the primary checkout (develop), where tickets start from
  2 Servers   turbo dev (pane 0) and ngrok (pane 1)
  3 Database  lazysql
  4 ABC-123   nvim + shell in ~/Path/To/Repo.feature-abc-123-...

Dash
  1 Dash      gh dash
  2 PR-901    tuicr + claude in the PR worktree

Dotfiles
  1 Config    nvim ~/Dotfiles

Mobile / Starity                     plain sessions, opened on demand
```

Worktrees are siblings of the repo, named `<repo>.<branch>`. The primary
checkout of App stays on `develop`, which Worktrunk treats as the default branch
(`wt config state default-branch set develop`, stored in the repo's local git
config).

## Daily flows

| Action              | Command                               | Effect                                                                                        |
| ------------------- | ------------------------------------- | --------------------------------------------------------------------------------------------- |
| Start a ticket      | `wtn feature/abc-123-foo`             | Branch from develop, worktree, env files and node_modules copied, window ABC-123 with Neovim  |
| Reopen a ticket     | `wtn feature/abc-123-foo`             | Same, existing branch reused                                                                  |
| Point servers at it | `wt srv` from the ticket shell        | Restarts turbo in that worktree, ngrok untouched                                              |
| Own database        | `wtdb` from the ticket shell          | Clones the main db, rewrites `DATABASE_URL` in the worktree, adds a lazysql connection        |
| Finish a ticket     | `wt remove feature/abc-123-foo`       | Drops the db, removes worktree and branch, closes the window                                  |
| Review a PR         | `D` in gh dash                        | PR worktree, window PR-N in Dash with tuicr and Claude                                        |
| Finish a review     | `wt remove` in the PR window          | Worktree and window gone; add `-D` to drop the local branch of an unmerged PR                 |
| Switch project      | `Prefix + T` or `sesh connect <name>` | Session created from `sesh.toml` if missing                                                   |
| Agent dashboard     | `Prefix + Ctrl + s`                   | Workmux popup listing running Claude sessions with live output and diffs                      |

## Files

| File                              | Role                           |
| --------------------------------- | ------------------------------ |
| `~/.config/worktrunk/config.toml` | Hooks and the `srv` alias      |
| `~/.config/sesh/sesh.toml`        | Session and window definitions |
| `~/.config/scripts/WtTicket.sh`   | `wtn`                          |
| `~/.config/scripts/WtReview.sh`   | gh-dash `D` key                |
| `~/.config/scripts/WtDb.sh`       | `wtdb` and the pre-remove drop |
| `~/.config/workmux/config.yaml`   | Dashboard only, window format left to catppuccin |

## Notes

- Only tickets that carry Prisma migrations need `wtdb`. The others share the
  main database.
- `wtdb` copies the database with `pg_dump`, so the dev server can stay up.
- [Workmux](https://github.com/raine/workmux) is used for its dashboard only. Its
  Claude hooks in `~/.claude/settings.json` track agent status next to the
  `claude-state.sh` badges; worktrees stay managed by Worktrunk.
- Window ids are stored per branch with `wt config state vars`. A tmux restart
  invalidates them, and the window then has to be closed by hand.
