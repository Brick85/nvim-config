local M = {}
local pickers
local finders
local conf
local sorters
local actions
local make_entry

M.setup = function()
	pickers = require("telescope.pickers")
	finders = require("telescope.finders")
	conf = require("telescope.config").values
	sorters = require("telescope.sorters")
	actions = require("telescope.actions")
	make_entry = require("telescope.make_entry")
end
M.live_multigrep = function(opts)
	opts = opts or {}
	opts.cwd = opts.cwd or vim.uv.cwd()

	local finder = finders.new_async_job({
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				return nil
			end
			local pieces = vim.split(prompt, "  ")
			local args = { "rg" }
			if pieces[1] then
				table.insert(args, "-e")
				table.insert(args, pieces[1])
			end
			if pieces[2] then
				table.insert(args, "-g")
				table.insert(args, pieces[2])
			end
			return vim.tbl_flatten({
				args,
				{
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
			})
		end,
		entry_maker = make_entry.gen_from_vimgrep(opts),
		cwd = opts.cwd,
	})
	pickers
		.new(opts, {
			prompt_title = "Live MultiGrep",
			finder = finder,
			previewer = conf.grep_previewer(opts),
			-- TODO: It would be cool to use `--json` output for this
			-- and then we could get the highlight positions directly.
			sorter = sorters.highlighter_only(opts),
			attach_mappings = function(_, map)
				map("i", "<c-space>", actions.to_fuzzy_refine)
				return true
			end,
		})
		:find()
end
return M
