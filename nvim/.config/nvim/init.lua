-- enable relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- custom insert mode exit
vim.keymap.set('i', 'jk', '<esc>', { desc = "Exit insert mode" })

-- enable syntax highlighting
vim.cmd[[syntax on]]

-- enavle lazy vim
require("config.lazy")
