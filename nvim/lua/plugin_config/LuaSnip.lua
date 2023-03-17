return function()

    local map = require("utils").map

    require("luasnip.loaders.from_lua").load({ paths = "./snippets" })

    function leave_snippet()
        if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
            and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require('luasnip').session.jump_active
        then
            require('luasnip').unlink_current()
        end
    end

    vim.api.nvim_create_autocmd("ModeChanged", {
        desc = "Stop snippets when you leave to normal mode",
        pattern = "*",
        command = "lua leave_snippet()",
    })

    map("i", "<C-n>", "<Plug>luasnip-next-choice")
    map("s", "<C-n>", "<Plug>luasnip-next-choice")
    map("i", "<C-p>", "<Plug>luasnip-prev-choice")
    map("i", "<C-p>", "<Plug>luasnip-prev-choice")

end
