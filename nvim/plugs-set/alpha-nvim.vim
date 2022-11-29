lua << EOF
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

math.randomseed( os.time() ) -- For random header.

-- Set header
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

local codingTime = {
    [[  /$$$$$$                  /$$ /$$                           /$$$$$$$$ /$$                            ]],
    [[ /$$__  $$                | $$|__/                          |__  $$__/|__/                            ]],
    [[| $$  \__/  /$$$$$$   /$$$$$$$ /$$ /$$$$$$$   /$$$$$$          | $$    /$$ /$$$$$$/$$$$   /$$$$$$     ]],
    [[| $$       /$$__  $$ /$$__  $$| $$| $$__  $$ /$$__  $$         | $$   | $$| $$_  $$_  $$ /$$__  $$    ]],
    [[| $$      | $$  \ $$| $$  | $$| $$| $$  \ $$| $$  \ $$         | $$   | $$| $$ \ $$ \ $$| $$$$$$$$    ]],
    [[| $$    $$| $$  | $$| $$  | $$| $$| $$  | $$| $$  | $$         | $$   | $$| $$ | $$ | $$| $$_____/    ]],
    [[|  $$$$$$/|  $$$$$$/|  $$$$$$$| $$| $$  | $$|  $$$$$$$         | $$   | $$| $$ | $$ | $$|  $$$$$$$    ]],
    [[ \______/  \______/  \_______/|__/|__/  |__/ \____  $$         |__/   |__/|__/ |__/ |__/ \_______/    ]],
    [[                                             /$$  \ $$                                                ]],
    [[                                            |  $$$$$$/                                                ]],
    [[                                             \______/                                                 ]],
}

local neovim = {
    [[/^^^     /^^ /^^^^^^^^    /^^^^     /^^         /^^ /^^ /^^       /^^    ]],
    [[/^ /^^   /^^ /^^        /^^    /^^   /^^       /^^  /^^ /^ /^^   /^^^    ]],
    [[/^^ /^^  /^^ /^^      /^^        /^^  /^^     /^^   /^^ /^^ /^^ / /^^    ]],
    [[/^^  /^^ /^^ /^^^^^^  /^^        /^^   /^^   /^^    /^^ /^^  /^^  /^^    ]],
    [[/^^   /^ /^^ /^^      /^^        /^^    /^^ /^^     /^^ /^^   /^  /^^    ]],
    [[/^^    /^ ^^ /^^        /^^     /^^      /^^^^      /^^ /^^       /^^    ]],
    [[/^^      /^^ /^^^^^^^^    /^^^^           /^^       /^^ /^^       /^^    ]],
}

local deathNote = {
    [[                                                                                  ,¿««r≥╦«,  .,,            ]],
    [[     _,yπªHºS?ªª≡2mj ╓,                                                     , ⌐*"]«∞%@j░*ⁿ%╦╦╦#╖µ^*┴┴¼w     ]],
    [[    ``             .└O+╝═`²""ª*P^]mx╕¡,                             ═*└```'.` .⌂,,'ªÑ╩*  "*K^*ªéG└T         ]],
    [[               ,¿≡═╜░^^X>*`_````╙"``ⁿⁿ┴░░/╓ç                     ÷>Ç≥".≥î?`    └╙ `*¬ ño                    ]],
    [[             `└    ¡dÜ═*"```  ""    ``ª*»⌂'░╙┐          ;Ü      @░ⁿ╠╚^"""└`                                 ]],
    [[                   `                      "╩½╕²┬.   ¡╨╟¼M╔╓  .e╙`¿*'                                        ]],
    [[                                            `*╕.`*═╣«╙`  `¥*?``v^                                           ]],
    [[                                               ╠  ``         A¿                                             ]],
    [[                                              .╛` '∩>²╙ºª',   `H                                            ]],
    [[                                              ^]."`         ». ╚Ñ                                           ]],
    [[                                              ╔"            V╙ `╔                                           ]],
    [[                                             i░             :└5`.┘                                          ]],
    [[                                              "⌐    .4╒~    ²  \.ù                                          ]],
    [[                                               ░   ╓1_`Hα;  `   ``_                                         ]],
    [[                                               .  .!H _M ╘`  u  µ.                                          ]],
    [[                                               ⌐  j       τ  ╘  . ⌐                                         ]],
    [[                                              £` `┴       `  `H └_¬                                         ]],
    [[                                              Σ  '⌐       .  `¿ ┌.u                                         ]],
    [[                                              »  ⁿ⌐       ò  ,]j;`┘                                         ]],
    [[                                              *``j       _>`╓\ ¥≥╒_                                         ]],
    [[                                               ╕`¡      _/`/`  ╒M^                                          ]],
    [[                                               ┤ └_    /└`╒                                                 ]],
    [[                                              .H`.     ê `                                                  ]],
    [[                                               º`^_    U j                                                  ]],
    [[                                               Ü``∩    " r                                                  ]],
    [[                                               ^ `ⁿ     ;b                                                  ]],
    [[                                                *ª~                                                         ]],
}

local MyHeaders= {naleuh, sombra, deathNote, codingTime, neovim}

dashboard.section.header.val = MyHeaders[math.random(#MyHeaders)]

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file"        , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "🔍 > Find file"       , ":Telescope find_files <CR>"),
    dashboard.button( "r", "📂 > Recent"          , ":Telescope oldfiles <CR>"),
    dashboard.button( "n", "🌳 > Toggle Nerdtree" , ":NERDTreeToggle <CR>"),
    dashboard.button( "s", "⛭  > Settings"        , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd <CR>"),
    dashboard.button( "q", "🚪 > Quit NVIM"       , ":qa <CR>"),
}

-- Set footer
local hiddenCat = {
    [[      ▄▀▄     ▄▀▄      ]],
    [[     ▄█░░▀▀▀▀▀░░█▄     ]],
    [[ ▄▄  █░░░░░░░░░░░█  ▄▄ ]],
    [[█▄▄█ █░░▀░░┬░░▀░░█ █▄▄█]],
}

local runningMan = {
    [[  ▄█▀█▄         ██    ]],
    [[▄████████▄   ▄▀█▄▄▄▄  ]],
    [[██▀▼▼▼▼▼▼  ▄▀  █▄▄    ]],
    [[████▄▲▲▲▲   ▄▄▀   ▀▄  ]],
    [[██████▀▀▀   ▀       ▀▀]],
}

local musicalNotes = {
    [[   ▄▀▌ ▄▄▄▄       ]],
    [[  ▄█   ▌ ▌ ▌ ▄▄▄▄ ]],
    [[▄▀ █▄  ▌ ▌ ▌ ▌ ▌ ▌]],
    [[█ ▀█ ▌█▌█▌█▌ ▌ ▌ ▌]],
    [[▀█▄█▀       █▌█▌█▌]],
    [[  ▄█▀             ]],
    [[ ▀▀               ]],
}

local coffee = {
    [[ ▄▀ ▄▀   ]],
    [[  ▀  ▀   ]],
    [[█▀▀▀▀▀█▄ ]],
    [[█░░░░░█ █]],
    [[▀▄▄▄▄▄▀▀ ]],
}

local failWhale = {
    [[  ▄▄▄▄▄▄▄▄▄▄▄▄▄▄ ▐█▄ ▄█]],
    [[██████▌▄▌▄▐▐▌███▌  ██▀ ]],
    [[████▄█▌▄▌▄▐▐▌▀███▄▄█▌  ]],
    [[▄▄▄▄▄██████████████▀   ]],

}

local pacman = {
    [[ ▒▒▒▒▒▒   ▄████▄  ]],
    [[▒ ▄▒ ▄▒  ███▄█▀   ]],
    [[▒▒▒▒▒▒▒ ▐████  █ █]],
    [[▒▒▒▒▒▒▒  █████▄   ]],
    [[▒ ▒ ▒ ▒   ▀████▀  ]],
}

local stfuTrain = {
    [[|^^^^^^^^^^^\||____     ]],
    [[| The STFU Truck |||""'|""\__,_ ]],
    [[| _____________  l||___|__|___|)]],
    [[...|(@)@)"""""""**|(@)(@)**|(@) ]],

}

local helloThere = {"Hello There"}

-- local MyFooters = require("alpha.fortune") -- Random set of sentences
local MyFooters = {hiddenCat, runningMan,musicalNotes, stfuTrain, failWhale, pacman, helloThere} -- Personnal sentences
dashboard.section.footer.val = MyFooters[math.random(#MyFooters)]

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
EOF
"
" local headers = {naleuh, sombra}
"
" local function header_chars()
"   math.randomseed(os.time())
"   return headers[math.random(#headers)]
" end
"
" -- Map over the headers, setting a different color for each line.
" -- This is done by setting the Highligh to StartLogoN, where N is the row index.
" -- Define StartLogo1..StartLogoN to get a nice gradient.
" local function header_color()
"   local lines = {}
"   for i, line_chars in pairs(header_chars()) do
"     local hi = "StartLogo" .. i
"     local line = {
"       type = "text",
"       val = line_chars,
"       opts = {
"         hl = hi,
"         shrink_margin = false,
"         position = "center",
"       },
"     }
"     table.insert(lines, line)
"   end
"
"   local output = {
"     type = "group",
"     val = lines,
"     opts = { position = "center", },
"   }
"
"   return output
" end
"
" local config = require("alpha.themes.theta").config
" config.layout[2] = header_color()
" alpha.setup(config)
" EOF
