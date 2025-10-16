vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

function ToggleFormatOnSave()
	vim.g.format_on_save = not vim.g.format_on_save
	if vim.g.format_on_save then
		require("fidget").notify("Format on save enabled")
	else
		require("fidget").notify("Format on save disabled")
	end
end

function FormatFile(on_save)
	if on_save and not vim.g.format_on_save then
		return
	end

	local fidget = require("fidget")
	vim.lsp.buf.format({
		filter = function(client)
			-- -- if client.name == "cssls" then
			-- --     return false
			-- -- end
			fidget.notify("Formatted " .. client.name)
			return true
		end,
		timeout_ms = 5000,
	})
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jay-babu/mason-null-ls.nvim",

			"hrsh7th/cmp-nvim-lsp",

			"nvimtools/none-ls.nvim",

			-- "stevearc/conform.nvim",
		},
		config = function()
			local localconf = require("qwe.localconf")
			-- local lspsettings = require("lsp-settings")
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }
					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua FormatFile(false)<cr>", opts)
					vim.keymap.set({ "n", "x" }, "<leader><F3>", "<cmd>lua ToggleFormatOnSave()<cr>", opts)
					-- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua ToggleFormatOnSave()<cr>", opts)
					vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
				end,
			})

			-- get capabilities
			local lspconfig_defaults = require("lspconfig").util.default_config
			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig_defaults.capabilities,
				require("cmp_nvim_lsp").default_capabilities()
			)
			-- /get capabilities

			require("mason").setup({})

			if localconf.ensure_installed ~= nil then
				require("mason-lspconfig").setup({
					ensure_installed = localconf.ensure_installed.lsp,
					handlers = {
						function() end,
					},
				})
				require("mason-null-ls").setup({
					ensure_installed = localconf.ensure_installed.null,
					-- automatic_installation = true,
					handlers = {
						function() end,
					},
				})
			end

			-- local lspconfig = vim.lsp.config()
			-- local lspconfig = require("lspconfig")
			local caps = vim.lsp.protocol.make_client_capabilities()
			local ok_cmp, cmp = pcall(require, "cmp_nvim_lsp")
			if ok_cmp then
				caps = cmp.default_capabilities(caps)
			end

			local default_setup_lsp = function(server)
				-- lspconfig[server].setup({
				-- 	capabilities = lspconfig_defaults,
				-- })
				vim.lsp.config(server, {
					capabilities = caps,
				})
				vim.lsp.enable(server)
			end
			local custom_setup_lsp = {
				lua_ls = function()
					-- lspconfig.lua_ls.setup({
					-- 	capabilities = lspconfig_defaults,
					-- 	settings = {
					-- 		Lua = {
					-- 			runtime = {
					-- 				version = "LuaJIT",
					-- 			},
					-- 			diagnostics = {
					-- 				globals = { "vim" },
					-- 			},
					-- 			workspace = {
					-- 				library = {
					-- 					vim.env.VIMRUNTIME,
					-- 				},
					-- 			},
					-- 		},
					-- 	},
					-- })
					vim.lsp.config("lua_ls", {
						capabilities = caps,
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								diagnostics = { globals = { "vim" } },
								workspace = {
									-- load Neovim runtime for full stdlib/`vim` awareness
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
								telemetry = { enable = false },
							},
						},
					})
					vim.lsp.enable("lua_ls")
				end,
			}
			-- ENABLE LSP
			if localconf.ensure_installed then
				for _, source in ipairs(localconf.ensure_installed.lsp) do
					if custom_setup_lsp[source] then
						custom_setup_lsp[source]()
					else
						default_setup_lsp(source)
					end
				end
			end
			if localconf.enabled then
				for _, source in ipairs(localconf.enabled.lsp) do
					if custom_setup_lsp[source] then
						custom_setup_lsp[source]()
					else
						default_setup_lsp(source)
					end
				end
			end
			-- /ENABLE LSP

			local null_ls = require("null-ls")
			local null_ls_sources = {}
			local null_ls_srcs = {
				isort = null_ls.builtins.formatting.isort,
				pylint = null_ls.builtins.diagnostics.pylint,
				djhtml = null_ls.builtins.formatting.djhtml,
				djlint = null_ls.builtins.formatting.djlint,
				stylua = null_ls.builtins.formatting.stylua,
				prettier = null_ls.builtins.formatting.prettier,
			}

			local default_setup_null = function(source)
				if null_ls_srcs[source] then
					table.insert(null_ls_sources, null_ls_srcs[source])
				else
					print("Unknown null_ls source: " .. source)
				end
			end
			local custom_setup_null = {
				blackd = function()
					table.insert(
						null_ls_sources,
						null_ls.builtins.formatting.blackd.with({
							config = {
								hostname = "blackd",
							},
						})
					)
				end,
				-- null_ls.builtins.formatting.prettierd.with({
				--    disabled_filetypes = { "sass", "scss", "css" },
				--    extra_filetypes = { "htmldjango" },
				-- }),
			}

			-- ENABLE NULL LS
			if localconf.ensure_installed then
				for _, source in ipairs(localconf.ensure_installed.null) do
					if custom_setup_null[source] then
						custom_setup_null[source]()
					else
						default_setup_null(source)
					end
				end
			end
			if localconf.enabled then
				for _, source in ipairs(localconf.enabled.null) do
					if custom_setup_null[source] then
						custom_setup_null[source]()
					else
						default_setup_null(source)
					end
				end
			end

			-- /ENABLE NULL LS

			null_ls.setup({
				-- on_attach = function(client, bufnr)
				-- 	if client.supports_method("textDocument/formatting") then
				-- 		vim.keymap.set("n", "<leader>fd", function()
				-- 			vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
				-- 			require("fidget").notify("Formatted null")
				-- 		end, { buffer = bufnr, desc = "[lsp] format" })
				-- 	end
				--
				-- 	if client.supports_method("textDocument/rangeFormatting") then
				-- 		vim.keymap.set("x", "<leader>fd", function()
				-- 			vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
				-- 			require("fidget").notify("Formatted partial null")
				-- 		end, { buffer = bufnr, desc = "[lsp] format" })
				-- 	end
				-- end,
				-- debug = true,
				sources = null_ls_sources,
			})

			local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
			local event = "BufWritePre" -- or "BufWritePost"
			-- local async = event == "BufWritePost"

			vim.g.format_on_save = true
			vim.api.nvim_create_autocmd(event, {
				group = group,
				callback = function()
					FormatFile(true)
				end,
				desc = "[lsp] format on save",
			})
		end,
	},
}
