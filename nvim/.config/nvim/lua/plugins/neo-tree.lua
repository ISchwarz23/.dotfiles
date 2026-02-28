return {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
                "MunifTanjim/nui.nvim",
        },
        config = function()
		vim.keymap.set('n', '<leader>e', ':Neotree reveal toggle<CR>', { desc = 'Neo-tree Reveal/Toggle' })

                vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
                vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})

		require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      visible = true, 
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {},
      never_show = { ".git" }
    },
  },
})

        end,
}
