local ensure_installed = {}
local ensure_installed_null = {}

if vim.env.VIMENV == "python" then
	-- table.insert(ensure_installed, "pylsp")
	-- table.insert(ensure_installed, "jedi_language_server")
	table.insert(ensure_installed, "pyright")
	table.insert(ensure_installed_null, "isort")
	table.insert(ensure_installed_null, "black")
end

if vim.env.VIMENV == "node" then
	table.insert(ensure_installed, "tsserver")
	table.insert(ensure_installed_null, "prettierd")
end

if vim.env.VIMENV == "golang" then
	table.insert(ensure_installed, "gopls")
end

local lsp_zero = require("lsp-zero")
lsp_zero.extend_cmp()

local cmp = require("cmp")
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-f>"] = cmp_action.luasnip_jump_forward(),
		["<C-g>"] = cmp_action.luasnip_jump_backward(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
	}),
})

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

require("mason").setup({})
require("mason-lspconfig").setup({
	automatic_installation = true,
	ensure_installed = ensure_installed,
	handlers = {
		lsp_zero.default_setup,

		tsserver = function()
			require("lspconfig").tsserver.setup({
				single_file_support = false,
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
				end,
			})
		end,
		pylsp = function()
			require("lspconfig").pylsp.setup({
				on_attach = function(client, bufnr)
					print("pylsp attached")
				end,
				settings = {
					pylsp = {
						plugins = {
							-- pyls_black = { enabled = true },
							-- isort = { enabled = true, profile = "black" },
							isort = { enabled = true },
							rope_autoimport = {
								enabled = true,
								completions = { enabled = true },
								code_actions = { enabled = true },
							},
						},
					},
				},
			})
		end,
	},
})
require("mason-null-ls").setup({
	ensure_installed = ensure_installed_null,
	handlers = {},
})

local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.keymap.set("n", "<Leader>f", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })

			-- format on save
			vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
			vim.api.nvim_create_autocmd(event, {
				buffer = bufnr,
				group = group,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, async = async })
				end,
				desc = "[lsp] format on save",
			})
		end

		if client.supports_method("textDocument/rangeFormatting") then
			vim.keymap.set("x", "<Leader>f", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })
		end
	end,
	debug = true,
})
