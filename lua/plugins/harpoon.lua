return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        -- "~/projects/harpoon",
        dependencies = { { "nvim-lua/plenary.nvim" } },
        lazy = true,
        opts = {},
        keys = {
            { "<leader>a", function() require("harpoon"):list():add() end,                                    "n" },
            { "<C-e>",     function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, "n" },
            { "<C-j>",     function() require("harpoon"):list():select(1) end,                                "n" },
            { "<C-k>",     function() require("harpoon"):list():select(2) end,                                "n" },
            { "<C-l>",     function() require("harpoon"):list():select(3) end,                                "n" },
            { "<C-h>",     function() require("harpoon"):list():select(4) end,                                "n" },
        }
    },
}
