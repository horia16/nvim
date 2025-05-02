-- SET LEADER BEFORE ANYTHING ELSE
vim.g.mapleader = " "

-- BASIC OPTIONS
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")

-- SHORTCUTS

vim.keymap.set("n", "<leader>i", function()
  local save_cursor = vim.api.nvim_win_get_cursor(0) -- save {line, col}
  vim.cmd("normal! gg=G") -- indent entire file
  vim.api.nvim_win_set_cursor(0, save_cursor) -- restore position
end, { desc = "Indent entire file", silent = true })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<C-\\>", "<C-w>p", { desc = "Switch to previous window" })

