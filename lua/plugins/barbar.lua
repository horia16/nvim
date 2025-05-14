return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",   -- optional: for Git icons
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
      clickable = false,
      icons = {
        buffer_index = true,
        inactive = { button = "" },
      },
    })
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Leader + number (1-9): Jump to buffer in that position
    for i = 1, 9 do
      map(
        "n",
        "<leader>b" .. i,
        "<Cmd>BufferGoto " .. i .. "<CR>",
        vim.tbl_extend("force", opts, {
          desc = "Go to buffer " .. i,
        })
      )
    end

    -- Leader + 0: Go to the last buffer
    map(
      "n",
      "<leader>b0",
      "<Cmd>BufferLast<CR>",
      vim.tbl_extend("force", opts, {
        desc = "Go to last buffer",
      })
    )

    -- Leader + n: Go to the next buffer
    map(
      "n",
      "<leader>bn",
      "<Cmd>BufferNext<CR>",
      vim.tbl_extend("force", opts, {
        desc = "Next buffer",
      })
    )

    -- Leader + N: Go to the previous buffer
    map(
      "n",
      "<leader>bN",
      "<Cmd>BufferPrevious<CR>",
      vim.tbl_extend("force", opts, {
        desc = "Previous buffer",
      })
    )

    -- Leader + c: Close current buffer
    map(
      "n",
      "<leader>bc",
      "<Cmd>BufferClose<CR>",
      vim.tbl_extend("force", opts, {
        desc = "Close buffer",
      })
    )
    map(
      "n",
      "<leader><leader>",
      "<Cmd>b#<CR>",
      vim.tbl_extend("force", opts, {
        desc = "Switch to last used buffer",
      })
    )
  end,
}
