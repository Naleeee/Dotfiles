lua << EOF
local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local cool = {
  [[    ███╗   ███╗ █████╗ ██╗  ██╗███████╗   ]],
  [[    ████╗ ████║██╔══██╗██║ ██╔╝██╔════╝   ]],
  [[    ██╔████╔██║███████║█████╔╝ █████╗     ]],
  [[    ██║╚██╔╝██║██╔══██║██╔═██╗ ██╔══╝     ]],
  [[    ██║ ╚═╝ ██║██║  ██║██║  ██╗███████╗   ]],
  [[    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ]],
  [[      ██████╗ ██████╗  ██████╗ ██╗        ]],
  [[     ██╔════╝██╔═══██╗██╔═══██╗██║        ]],
  [[     ██║     ██║   ██║██║   ██║██║        ]],
  [[     ██║     ██║   ██║██║   ██║██║        ]],
  [[     ╚██████╗╚██████╔╝╚██████╔╝███████╗   ]],
  [[      ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝   ]],
  [[███████╗████████╗██╗   ██╗███████╗███████╗]],
  [[██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝]],
  [[███████╗   ██║   ██║   ██║█████╗  █████╗  ]],
  [[╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝  ]],
  [[███████║   ██║   ╚██████╔╝██║     ██║     ]],
  [[╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ]],
}

local robust = {
  [[        ██████╗ ██╗   ██╗██╗██╗     ██████╗         ]],
  [[        ██╔══██╗██║   ██║██║██║     ██╔══██╗        ]],
  [[        ██████╔╝██║   ██║██║██║     ██║  ██║        ]],
  [[        ██╔══██╗██║   ██║██║██║     ██║  ██║        ]],
  [[        ██████╔╝╚██████╔╝██║███████╗██████╔╝        ]],
  [[        ╚═════╝  ╚═════╝ ╚═╝╚══════╝╚═════╝         ]],
  [[ ██████╗  ██████╗ ██████╗ ██╗   ██╗███████╗████████╗]],
  [[ ██╔══██╗██╔═══██╗██╔══██╗██║   ██║██╔════╝╚══██╔══╝]],
  [[ ██████╔╝██║   ██║██████╔╝██║   ██║███████╗   ██║   ]],
  [[ ██╔══██╗██║   ██║██╔══██╗██║   ██║╚════██║   ██║   ]],
  [[ ██║  ██║╚██████╔╝██████╔╝╚██████╔╝███████║   ██║   ]],
  [[ ╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝   ╚═╝   ]],
  [[     ███████╗████████╗██╗   ██╗███████╗███████╗     ]],
  [[     ██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝     ]],
  [[     ███████╗   ██║   ██║   ██║█████╗  █████╗       ]],
  [[     ╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝       ]],
  [[     ███████║   ██║   ╚██████╔╝██║     ██║          ]],
  [[     ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝          ]],
}

local naleuh = {
  [[███╗   ██╗ █████╗ ██╗     ███████╗██╗   ██╗██╗  ██╗]],
  [[████╗  ██║██╔══██╗██║     ██╔════╝██║   ██║██║  ██║]],
  [[██╔██╗ ██║███████║██║     █████╗  ██║   ██║███████║]],
  [[██║╚██╗██║██╔══██║██║     ██╔══╝  ██║   ██║██╔══██║]],
  [[██║ ╚████║██║  ██║███████╗███████╗╚██████╔╝██║  ██║]],
  [[╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝]],
}

local sombra = {
    [[                     :PB@Bk:                     ]],
    [[                 ,jB@@B@B@B@BBL.                 ]],
    [[              7G@B@B@BMMMMMB@B@B@Nr              ]],
    [[          :kB@B@@@MMOMOMOMOMMMM@B@B@B1,          ]],
    [[      :5@B@B@B@BBMMOMOMOMOMOMOMM@@@B@B@BBu.      ]],
    [[   70@@@B@B@B@BXBBOMOMOMOMOMOMMBMPB@B@B@B@B@Nr   ]],
    [[ G@@@BJ iB@B@@  OBMOMOMOMOMOMOM@2  B@B@B. EB@B@S ]],
    [[ @@BM@GJBU.  iSuB@OMOMOMOMOMOMM@OU1:  .kBLM@M@B@ ]],
    [[ B@MMB@B       7@BBMMOMOMOMOMOBB@:       B@BMM@B ]],
    [[ @@@B@B         7@@@MMOMOMOMM@B@:         @@B@B@ ]],
    [[ @@OLB.          BNB@MMOMOMM@BEB          rBjM@B ]],
    [[ @@  @           M  OBOMOMM@q  M          .@  @@ ]],
    [[ @@OvB           B:u@MMOMOMMBJiB          .BvM@B ]],
    [[ @B@B@J         0@B@MMOMOMOMB@B@u         q@@@B@ ]],
    [[ B@MBB@v       G@@BMMMMMMMMMMMBB@5       F@BMM@B ]],
    [[ @BBM@BPNi   LMEB@OMMMM@B@MMOMM@BZM7   rEqB@MBB@ ]],
    [[ B@@@BM  B@B@B  qBMOMB@B@B@BMOMBL  B@B@B  @B@B@M ]],
    [[  J@@@@PB@B@B@B7G@OMBB.   ,@MMM@qLB@B@@@BqB@BBv  ]],
    [[     iGB@,i0@M@B@MMO@E  :  M@OMM@@@B@Pii@@N:     ]],
    [[            B@M@B@MMM@B@B@B@MMM@@@M@B            ]],
    [[            @B@B.i@MBB@B@B@@BM@::B@B@            ]],
    [[            B@@@ .B@B.:@B@ :B@B  @B@O            ]],
    [[              :0 r@B@  B@@ .@B@: P:              ]],
    [[                  vMB :@B@ :BO7                  ]],
    [[                      ,B@B                       ]],
}

local headers = {naleuh, sombra}

local function header_chars()
  math.randomseed(os.time())
  return headers[math.random(#headers)]
end

-- Map over the headers, setting a different color for each line.
-- This is done by setting the Highligh to StartLogoN, where N is the row index.
-- Define StartLogo1..StartLogoN to get a nice gradient.
local function header_color()
  local lines = {}
  for i, line_chars in pairs(header_chars()) do
    local hi = "StartLogo" .. i
    local line = {
      type = "text",
      val = line_chars,
      opts = {
        hl = hi,
        shrink_margin = false,
        position = "center",
      },
    }
    table.insert(lines, line)
  end

  local output = {
    type = "group",
    val = lines,
    opts = { position = "center", },
  }

  return output
end

local config = require("alpha.themes.theta").config
config.layout[2] = header_color()
alpha.setup(config)
EOF
