-- enable relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- custom insert mode exit
vim.keymap.set('i', 'jk', '<esc>', { desc = "Exit insert mode" })

-- make background transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
