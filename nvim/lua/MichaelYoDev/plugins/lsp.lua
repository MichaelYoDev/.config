return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "mason-org/mason.nvim",           version = "^1.0.0" },
        { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
        -- "mason-org/mason.nvim",
        -- "mason-org/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
    },

    config = function()
        vim.diagnostic.config({
            float = { border = "rounded" }
        })

        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_installation = false,
            ensure_installed = {
                "lua_ls",
                -- "rust_analyzer",
                "pylsp",
                -- "jdtls",
                "gopls",
                "tinymist",
                "ts_ls",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ["tinymist"] = function()
                    require("lspconfig")["tinymist"].setup {
                        capabilities = capabilities,
                        settings = {
                            formatterMode = "typstyle",
                            formatterIndentSize = 4,
                            exportPdf = "never"
                        },
                    }
                end,
            }

        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        vim.api.nvim_set_hl(0, "CmpNormal", {})
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-e>'] = vim.NIL
            }),

            window = {
                completion = {
                    scrollbar = false,
                    border = "rounded",
                    winhighlight = "Normal:CmpNormal",
                },
                documentation = {
                    scrollbar = false,
                    border = "rounded",
                    winhighlight = "Normal:CmpNormal",
                }
            },
            sources = cmp.config.sources({
                {
                    name = "nvim_lsp",
                    entry_filter = function(entry, ctx)
                        return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
                    end,
                },
                { name = 'cmp-tw2css' },
            }, {})
        })


        local autocmd = vim.api.nvim_create_autocmd
        autocmd({ "BufEnter", "BufWinEnter" }, {
            pattern = { "*.vert", "*.frag" },
            callback = function(e)
                vim.cmd("set filetype=glsl")
            end

        })

        local hover = vim.lsp.buf.hover
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.lsp.buf.hover = function()
            return hover({
                border = "rounded",
                -- max_width = 100,
                max_width = math.floor(vim.o.columns * 0.7),
                max_height = math.floor(vim.o.lines * 0.7),
            })
        end

        autocmd('LspAttach', {
            callback = function(e)
                local opts = { buffer = e.buf }
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
                vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("n", "<leader>lk", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "<leader>ln", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "<leader>lp", function() vim.diagnostic.goto_prev() end, opts)
            end
        })
    end
}
