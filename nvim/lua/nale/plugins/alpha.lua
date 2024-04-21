return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Define headers
		local naleuh = {
			[[███╗   ██╗ █████╗ ██╗     ███████╗██╗   ██╗██╗  ██╗]],
			[[████╗  ██║██╔══██╗██║     ██╔════╝██║   ██║██║  ██║]],
			[[██╔██╗ ██║███████║██║     █████╗  ██║   ██║███████║]],
			[[██║╚██╗██║██╔══██║██║     ██╔══╝  ██║   ██║██╔══██║]],
			[[██║ ╚████║██║  ██║███████╗███████╗╚██████╔╝██║  ██║]],
			[[╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝]],
		}

		local code = {
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

		local ryuk = {
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

		local error = {
			[[        :::      :::::::      ::: ]],
			[[      :+:      :+:   :+:    :+:   ]],
			[[    +:+ +:+   +:+   +:+   +:+ +:+ ]],
			[[  +#+  +:+   +#+   +:+  +#+  +:+  ]],
			[[+#+#+#+#+#+ +#+   +#+ +#+#+#+#+#+ ]],
			[[     #+#   #+#   #+#       #+#    ]],
			[[    ###    #######        ###     ]],
		}

		local neovim = {
			[[                                                     ]],
			[[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
			[[  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
			[[  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
			[[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
			[[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
			[[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
			[[                                                     ]],
		}

		-- Set header
		local myHeaders = { naleuh, ryuk, code, neovim, error }
		math.randomseed(os.time()) -- For random header

		dashboard.section.header.val = myHeaders[math.random(#myHeaders)]

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "𐇲  > Toggle file tree", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("f", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("g", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("r", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
			dashboard.button("q", "🮲🮳 > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Define footer
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

		local sleepyRabbit = {
			[[(\(\]],
			[[( ~.~)    Approved by a sleepy rabbit.]],
			[[O(")(")]],
		}

		local noToAny = {
			[[  ________________]],
			[[ |                |]],
			[[ |      NO TO     |]],
			[[ |      ANY       |]],
			[[ |________________|]],
			[[(\__/)  ||]],
			[[(ᗒᗣᗕ)   ||]],
			[[/    \っ||]],
		}

		local helloThere = { "Hello There" }

		local myFooters = {
			hiddenCat,
			runningMan,
			musicalNotes,
			stfuTrain,
			failWhale,
			pacman,
			helloThere,
			sleepyRabbit,
			noToAny,
		}
		dashboard.section.footer.val = myFooters[math.random(#myFooters)]

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
