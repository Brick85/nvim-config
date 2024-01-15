local M = {}

M.ensure_installed = {
    "pyright",
    "lua_ls",
    "html",
    "cssls",
    "yamlls",
    "jsonls",
    "tsserver",
    -- "gopls",
}

M.ensure_installed_null = {
    "prettierd",
    -- "black",
    -- "isort",
}

M.setup = function(lsp_capabilities)
    require('lspconfig').lua_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT'
                },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = {
                        vim.env.VIMRUNTIME,
                    }
                }
            }
        }
    })
    -- tsserver = function()
    -- 	require("lspconfig").tsserver.setup({
    -- 		single_file_support = false,
    -- 		on_attach = function(client, bufnr)
    -- 			client.server_capabilities.documentFormattingProvider = false
    -- 		end,
    -- 	})
    -- end,
    -- pylsp = function()
    -- 	require("lspconfig").pylsp.setup({
    -- 		on_attach = function(client, bufnr)
    -- 			print("pylsp attached")
    -- 		end,
    -- 		settings = {
    -- 			pylsp = {
    -- 				plugins = {
    -- 					-- pyls_black = { enabled = true },
    -- 					-- isort = { enabled = true, profile = "black" },
    -- 					isort = { enabled = true },
    -- 					rope_autoimport = {
    -- 						enabled = true,
    -- 						completions = { enabled = true },
    -- 						code_actions = { enabled = true },
    -- 					},
    -- 				},
    -- 			},
    -- 		},
    -- 	})
    -- end,
end


return M
