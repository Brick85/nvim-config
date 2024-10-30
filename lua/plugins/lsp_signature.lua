return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	opts = {},
	config = function(_, opts)
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then
					return
				end
				if vim.tbl_contains({ "null-ls", "copilot" }, client.name) then -- blacklist lsp
					return
				end
				local success1, lsig = pcall(require, "lsp_signature")
				if not success1 then
					print("Error imporning for " .. client.name .. " lsp_signature: " .. lsig)
					return
				end
				local success2, err = pcall(lsig.on_attach, opts, bufnr)
				if not success2 then
					print("Error attaching to " .. client.name .. " lsp_signature: " .. err)
				end
				-- require("lsp_signature").on_attach(opts, bufnr)
			end,
		})
		-- require("lsp_signature").setup(opts)
	end,
}
