return function()

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip = require("luasnip")
    local cmp = require("cmp")
    local kind_icons = {
        Text = " ",
        Method = " ",
        Function = " ",
        Constructor = " ",
        Field = "ﴲ ",
        Variable = " ",
        Class = " ",
        Interface = "ﰮ ",
        Module = " ",
        Property = "襁 ",
        Unit = " ",
        Value = " ",
        Enum = "練 ",
        Keyword = " ",
        Snippet = " ",
        Color = " ",
        File = " ",
        Reference = " ",
        Folder = " ",
        EnumMember = " ",
        Constant = "ﲀ ",
        Struct = "ﳤ ",
        Event = " ",
        Operator = " ",
        TypeParameter = " "
    }
    local ELLIPSIS_CHAR = "…"
    local MAX_LABEL_WIDTH = 69

    cmp.setup({
        sources = {
            { name = "luasnip" },
            { name = "nvim_lsp" },
            { name = "cmp_tabnine" },
        },
        snippet = {
            expand = function(args)
                if not luasnip then
                    return
                end
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = {
            ["<CR>"] = cmp.mapping.confirm { select = true },
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<Esc>"] = cmp.mapping.abort(),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
        formatting = {
            format = function(entry, vim_item)

                vim_item.kind = string.format("%s(%s)", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind

                vim_item.menu = ({
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    cmp_tabnine = "[Tabnine]",
                    luasnip = "[LuaSnip]",
                    nvim_lua = "[Lua]",
                    latex_symbols = "[LaTeX]",
                })[entry.source.name]

                local label = vim_item.abbr
                local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)

                if truncated_label ~= label then
                    vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
                end

                return vim_item
            end
        }
    })
end
