return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional for icons
    config = function()
      require('lualine').setup {
        options = {
          theme = 'auto',        -- or try 'gruvbox', 'onedark', etc.
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },  -- This shows the mode beautifully!
          lualine_b = { 'filename', 'filetype' },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        }
      }
    end
  },
  { 'nvim-tree/nvim-web-devicons', lazy = true }
}
