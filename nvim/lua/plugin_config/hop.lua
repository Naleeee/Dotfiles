return function()
    local map = require("utils").map

    require("hop").setup()

    map("n", "<leader>l", "<Cmd>HopWord<CR>")
end
