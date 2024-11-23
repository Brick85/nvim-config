return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        -- lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            -- "nvim-telescope/telescope-file-browser.nvim",
        },
        keys = {
            {
                "<leader>ps",
                function()
                    require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
                end,
                "n",
            },
            {
                "<leader>ff",
                function()
                    require("telescope.builtin").find_files()
                end,
                "n",
            },
            {
                "<leader>fg",
                function()
                    require("telescope.builtin").live_grep()
                end,
                "n",
            },
            {
                "<leader>fb",
                function()
                    require("telescope.builtin").buffers()
                end,
                "n",
            },
            {
                "<leader>fh",
                function()
                    require("telescope.builtin").help_tags()
                end,
                "n",
            },
            {
                "<leader>fr",
                function()
                    require("telescope.builtin").resume()
                end,
                "n",
            },
            {
                "<leader>ft",
                function()
                    require("telescope.builtin").lsp_references()
                end,
                "n",
            },
            {
                "<leader>pf",
                function()
                    require("telescope").extensions.file_browser.file_browser({ select_buffer = true, path = "%:p:h" })
                end,
                "n",
            },
        },
        -- opts = {
        --     defaults = {
        --         file_ignore_patterns = { "node_modules", ".git", ".cache", "__pycache__", "migrations" },
        --     },
        -- },
        config = function()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = { "node_modules", ".git", ".cache", "__pycache__", "migrations" },
                },
                extensions = {
                    -- file_browser = {
                    -- 	-- theme = "ivy",
                    -- 	-- disables netrw and use telescope-file-browser in its place
                    -- 	-- hijack_netrw = true,
                    -- 	sorting_strategy = "ascending",
                    -- 	-- mappings = {
                    -- 	--     ["i"] = {
                    -- 	--         -- your custom insert mode mappings
                    -- 	--     },
                    -- 	--     ["n"] = {
                    -- 	--         -- your custom normal mode mappings
                    -- 	--     },
                    -- 	-- },
                    -- },
                },
            })
            require("telescope").load_extension("ui-select")
            -- require("telescope").load_extension("file_browser")
        end,
    },
}
