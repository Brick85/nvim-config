-- Function to open terminal in a floating window
function OpenCenteredTerminal()
	-- Define dimensions of the terminal window
	local width = math.floor(vim.o.columns * 0.8) -- 80% of editor width
	local height = math.floor(vim.o.lines * 0.6) -- 60% of editor height
	local row = math.floor((vim.o.lines - height) / 2) -- Center vertically
	local col = math.floor((vim.o.columns - width) / 2) -- Center horizontally

	-- Create a buffer for the terminal
	local buf = vim.api.nvim_create_buf(false, true) -- No buffer listed, scratch buffer

	-- Window options
	local opts = {
		style = "minimal", -- Minimal style, no borders
		relative = "editor", -- Relative to the entire editor
		width = width,
		height = height,
		row = row,
		col = col,
		border = "single",
	}

	-- Create the floating window

	local win = vim.api.nvim_open_win(buf, true, opts)

	local function on_exit(job_id, exit_code, event_type)
		if exit_code == 0 then
			vim.api.nvim_win_close(win, true) -- Close the floating window
		end
	end

	local shell = vim.o.shell
	shell = "bash"
	vim.fn.termopen(shell, { on_exit = on_exit })
	vim.cmd("startinsert")

	-- vim.api.nvim_buf_set_keymap(buf, "t", "<Esc><Esc>", "<C-\\><C-n>:close<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(buf, "t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
end

-- vim.api.nvim_set_keymap("n", "<leader>tt", ":lua OpenCenteredTerminal()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tt", OpenCenteredTerminal)
