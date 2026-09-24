return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		-- Hidden buffers from every monorepo app would make tsserver load all projects at once
		vim.opt.sessionoptions:remove("buffers")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
		})
	end,
}
