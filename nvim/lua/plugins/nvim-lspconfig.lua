return {
    'neovim/nvim-lspconfig',
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")

        -- Define on_attach function to set up keybindings
        local on_attach = function(client, bufnr)
            -- Create an autocommand group for the buffer
            local augroup = vim.api.nvim_create_augroup("LspSignatureHelp", { clear = true })
            
            -- Add autocommand for signature help
            vim.api.nvim_create_autocmd("CursorHoldI", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.signature_help()
                end,
            })

            -- Set updatetime for faster signature help response
            vim.opt.updatetime = 300
        end

        -- Set up proper capabilities with snippet support
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.completion.completionItem.resolveSupport = {
            properties = {
                'documentation',
                'detail',
                'additionalTextEdits',
            }
        }
        -- Enhanced signature help capability
        capabilities.textDocument.signatureHelp = {
            signatureInformation = {
                activeParameterSupport = true,
                parameterInformation = {
                    labelOffsetSupport = true,
                },
                documentationFormat = { 'markdown', 'plaintext' },
            },
            contextSupport = true,
        }

        -- Define the gopls setup configuration
        local gopls_config = {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            settings = {
                gopls = {
                    completeUnimported = true,
                    usePlaceholders = true,
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                }
            }
        }

        -- Let mason-lspconfig handle the initial setup
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end,
            ["gopls"] = function()
                lspconfig.gopls.setup(gopls_config)
            end,
        })

        -- Add autocommand for formatting Go files on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                -- Organize imports
                local params = vim.lsp.util.make_range_params()
                params.context = {only = {"source.organizeImports"}}
                local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
                for cid, res in pairs(result or {}) do
                    for _, r in pairs(res.result or {}) do
                        if r.edit then
                            local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                            vim.lsp.util.apply_workspace_edit(r.edit, enc)
                        end
                    end
                end
                -- Format the file
                vim.lsp.buf.format({async = false})
            end
        })
    end,
}
