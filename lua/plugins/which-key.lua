return {
  {
    "echasnovski/mini.icons",
    version = false,
    lazy = true,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        -- optional configuration
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
        win = {
          border = "rounded",
        },
        layout = {
          spacing = 6,
        },
      })
    end,
  },
}
