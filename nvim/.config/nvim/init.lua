-- enable relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- custom insert mode exit
vim.keymap.set('i', 'jk', '<esc>', { desc = "Exit insert mode" })

-- enable syntax highlighting
vim.cmd[[syntax on]]

-- enavle lazy vim
require("config.lazy")

-- make background transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
