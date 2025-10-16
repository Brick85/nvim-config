return {

	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local cmp = require("cmp")

		cmp.setup({
			sources = {
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "buffer", keyword_length = 3, max_item_count = 5 },
				-- { name = "buffer" },
				{ name = "path" },
				per_filetype = {
					codecompanion = { "codecompanion" },
				},
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
	end,
}
