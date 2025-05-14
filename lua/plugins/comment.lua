return {
  "numToStr/Comment.nvim",
  opts = {
    -- add any options here
  },
  config = function()
    require("Comment").setup({
      mappings = false,
    })
    vim.keymap.set("n", "<leader>/", function()
      require("Comment.api").toggle.linewise.current()
    end, { desc = "Toggle line comment (current line)", noremap = true, silent = true })

    -- Toggle comment for selected lines in visual mode
    vim.keymap.set("v", "<leader>/", function()
      -- Get visual mode type (v/V/CTRL-V)
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
      vim.api.nvim_feedkeys(esc, "nx", false)
      require("Comment.api").toggle.linewise(vim.fn.visualmode())
    end, { desc = "Toggle line comment (selection)", noremap = true, silent = true })
  end,
}
