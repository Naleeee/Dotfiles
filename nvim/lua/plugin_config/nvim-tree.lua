return function()
    local map = require("utils").map

    require("nvim-tree").setup()

    map("n", "<C-n>", "<Cmd>NvimTreeToggle<CR>")
end
