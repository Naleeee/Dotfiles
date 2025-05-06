return {
	"CopilotC-Nvim/CopilotChat.nvim",
	event = "VeryLazy",
	dependancies = {
		{ "github/copilot.vim" },
		{ "nvim-lua/plenary.nvim", branch = "main" },
	},
	build = "make tiktoken", -- Only macos / linux
	opts = {
		prompts = {
			Rename = {
				prompt = "Please rename the variable correctly in given selection based on context",
				selection = function(source)
					local select = require("copilot.chat.select")
					return select.visual(source)
				end,
			},
		},
	},
	keys = {
		{ "<leader>zc", "<cmd>CopilotChat<CR>", mode = "n", desc = "Chat with Copilot" },
		{ "<leader>zc", "<cmd>CopilotChat<CR>", mode = "v", desc = "Chat with Copilot" },
		{ "<leader>ze", "<cmd>CopilotChatExplain<CR>", mode = "v", desc = "Explain code" },
		{ "<leader>zr", "<cmd>CopilotChatReview<CR>", mode = "n", desc = "Review code" },
		{ "<leader>zf", "<cmd>CopilotChatFix<CR>", mode = "n", desc = "Fix code issues" },
		{ "<leader>zo", "<cmd>CopilotChatOptimize<CR>", mode = "n", desc = "Optimize code" },
		{ "<leader>zd", "<cmd>CopilotChatDocs<CR>", mode = "n", desc = "Generate docs" },
		{ "<leader>zt", "<cmd>CopilotChatTests<CR>", mode = "n", desc = "Generate tests" },
	},
}
