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
			if client.name == "cssls" then
				return false
			end
			fidget.notify("Formatted " .. client.name)
			return true
		end,
	})
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			-- "jose-elias-alvarez/null-ls.nvim",
			"nvimtools/none-ls.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
		config = function()
			local lspsettings = require("lsp-settings")
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
					vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
				end,
			})

			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			local default_setup = function(server)
				require("lspconfig")[server].setup({
					capabilities = lsp_capabilities,
				})
			end

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = lspsettings.ensure_installed,
				handlers = {
					default_setup,
				},
			})

			local cmp = require("cmp")

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					-- { name = "buffer", keyword_length = 3, max_item_count = 5 },
					{ name = "buffer" },
					{ name = "path" },
				},
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<C-CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					-- ["<C-f>"] = cmp_action.luasnip_jump_forward(),
					-- ["<C-g>"] = cmp_action.luasnip_jump_backward(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					format = function(entry, vim_item)
						-- vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							buffer = "[Buffer]",
							path = "[Path]",
						})[entry.source.name]
						return vim_item
					end,
				},
			})

			-- require("mason-null-ls").setup({
			--     ensure_installed = lspsettings.ensure_installed_null,
			--     handlers = {},
			-- })

			local null_ls = require("null-ls")

			local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
			local event = "BufWritePre" -- or "BufWritePost"
			-- local async = event == "BufWritePost"

			null_ls.setup({
				-- on_attach = function(client, bufnr)
				--     if client.supports_method("textDocument/formatting") then
				--         -- vim.keymap.set("n", "<Leader>f", function()
				--         vim.keymap.set("n", "<leader>fd", function()
				--             vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
				--             require("fidget").notify("Formatted null")
				--         end, { buffer = bufnr, desc = "[lsp] format" })
				--
				--         -- -- format on save
				--         -- vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
				--         -- vim.api.nvim_create_autocmd(event, {
				--         --     buffer = bufnr,
				--         --     group = group,
				--         --     callback = function()
				--         --         vim.lsp.buf.format({ bufnr = bufnr, async = async })
				--         --     end,
				--         --     desc = "[lsp] format on save",
				--         -- })
				--     end
				--
				--     if client.supports_method("textDocument/rangeFormatting") then
				--         vim.keymap.set("x", "<Leader>fd", function()
				--             vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
				--         end, { buffer = bufnr, desc = "[lsp] format" })
				--     end
				-- end,
				debug = true,
				-- sources = {
				--     null_ls.builtins.formatting.prettierd.with({
				--         extra_filetypes = { "htmldjango" },
				--     }), }
				-- },
				sources = {
					null_ls.builtins.formatting.djhtml,
					-- null_ls.builtins.formatting.djlint,
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.blackd,
					null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.formatting.prettierd.with({
					--     disabled_filetypes = { "sass", "scss", "css" },
					-- }),
				},
			})

			-- local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
			-- local event = "BufWritePre" -- or "BufWritePost"
			-- local async = event == "BufWritePost"
			vim.g.format_on_save = true
			vim.api.nvim_create_autocmd(event, {
				group = group,
				callback = function()
					FormatFile(true)
				end,
				desc = "[lsp] format on save",
			})

			lspsettings.setup(lsp_capabilities)
		end,
	},
}
