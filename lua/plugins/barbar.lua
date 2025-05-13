return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",     -- optional: for Git icons
    "nvim-tree/nvim-web-devicons", -- optional: for filetype icons
  },
  init = function()
    vim.g.barbar_auto_setup = false -- disable auto-setup, configure manually
  end,
  config = function()
    require("barbar").setup({
      animation = true,
      auto_hide = false,
      tabpages = true,
      clickable = true,
      icons = {
        buffer_index= true,
      }
    })
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Leader + number (1-9) to go to buffer position
    for i = 1, 9 do
      map("n", "<leader>" .. i, "<Cmd>BufferGoto " .. i .. "<CR>", opts)
    end
    -- Leader + 0 to go to last buffer
    map("n", "<leader>0", "<Cmd>BufferLast<CR>", opts)

    -- Leader + n / N for next / previous buffer
    map("n", "<leader>n", "<Cmd>BufferNext<CR>", opts)
    map("n", "<leader>N", "<Cmd>BufferPrevious<CR>", opts)
  end
}
