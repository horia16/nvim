-- SET LEADER BEFORE ANYTHING ELSE
vim.g.mapleader = " "
local opt = vim.opt

vim.cmd("set number")

-- Text layout
opt.tabstop = 2         -- A tab character (`\t`) appears as 2 spaces
opt.shiftwidth = 2      -- Indent lines with 2 spaces (e.g. with >>)
opt.softtabstop = 2     -- Pressing <Tab> inserts 2 spaces (feels like a tab)
opt.expandtab = true    -- Convert tabs to spaces (no literal `\t` characters)

opt.wrap = false        -- Don't wrap long lines (let them overflow)

opt.list = true         -- Show invisible characters (trailing spaces, tabs, etc.)
opt.listchars = {
  trail = "•",          -- Show trailing spaces as •
  nbsp = "␣",           -- Show non-breaking spaces as ␣
  tab = "» "            -- Show tab characters as » followed by a space
}


-- SHORTCUTS

vim.keymap.set("n", "<leader>i", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format entire file via LSP", silent = true })

vim.keymap.set("n", "<leader>I", function()
  local save_cursor = vim.api.nvim_win_get_cursor(0)
  vim.cmd("normal! gg=G")
  vim.api.nvim_win_set_cursor(0, save_cursor)
end, { desc = "Indent via Vim", silent = true })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<C-\\>", "<C-w>p", { desc = "Switch to previous window" })

vim.keymap.set("n", "<leader>v", ":vsplit<CR>", {
  noremap = true,
  silent = true,
  desc = "Vertical Split",
})

vim.keymap.set("n", "<leader>.", ":vertical resize +5<CR>", {
  noremap = true,
  silent = true,
  desc = "Increase Width",
})

vim.keymap.set("n", "<leader>,", ":vertical resize -5<CR>", {
  noremap = true,
  silent = true,
  desc = "Decrease Width",
})

vim.api.nvim_create_user_command("Squit", function()
  -- Close Neo-tree filesystem
  vim.cmd("Neotree filesystem close")
  -- Save session
  vim.cmd("SessionSave")
  -- Write all and quit
  vim.cmd("wqa")
end, {})

-- Smart case-sensitive searching
vim.o.ignorecase = true -- Ignore case by default
vim.o.smartcase = true  -- But make it case-sensitive if the search contains uppercase

-- File management
opt.backup = false      -- Don't create backup files
opt.swapfile = false    -- Don't use swap files
opt.undofile = true     -- Enable persistent undo (save undo history across sessions)

-- Clear search highlights when pressing <Esc>
vim.keymap.set("n", "<Esc>", function()
  if vim.v.hlsearch == 1 then
    vim.cmd("nohlsearch")
    vim.fn.setreg("/", "")
  else
    -- send actual <Esc> key
    return "<Esc>"
  end
end, { expr = true, noremap = true, silent = true, desc = "Clear search highlight or escape" })

-- Visual mode indentation with Tab and Shift-Tab
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Indent left and reselect" })

-- Clipboard stuff
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to OS clipboard" })

-- Copy the path to OS clipboard
vim.api.nvim_create_user_command("CopyPath", function(context)
  local full_path = vim.fn.glob("%:p")

  local file_path = nil
  if context["args"] == "nameonly" then
    file_path = vim.fn.fnamemodify(full_path, ":t")
  end

  -- get the file path relative to project root
  if context["args"] == "relative" then
    local project_marker = { ".git", "pyproject.toml" }
    local project_root = vim.fs.root(0, project_marker)
    if project_root == nil then
      vim.print("can not find project root")
      return
    end

    file_path = string.gsub(full_path, project_root, "<project-root>")
  end

  if context["args"] == "absolute" then
    file_path = full_path
  end

  vim.fn.setreg("+", file_path)
  vim.print("Filepath copied to clipboard!")
end, {
  bang = false,
  nargs = 1,
  force = true,
  desc = "Copy current file path to clipboard",
  complete = function()
    return { "nameonly", "relative", "absolute" }
  end,
})
