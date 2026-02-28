vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

-- enable relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- custom insert mode exit
vim.keymap.set('i', 'jk', '<esc>', { desc = "Exit insert mode" })

-- navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- open terminal in a bottom split
vim.keymap.set('n', '<leader>t', function()
  vim.cmd("botright split")
  vim.cmd("term")
  vim.cmd("resize 10")
end, { desc = "Open bottom terminal" })

-- exit terminal mode 
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { desc = "Exit terminal mode" })
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- automatically start insert mode when opening a terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.cmd("startinsert")
    -- disable line numbers in terminal for a cleaner look
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- make background transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
