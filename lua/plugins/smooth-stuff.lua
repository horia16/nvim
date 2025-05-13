return {
  {
    "sphamba/smear-cursor.nvim",
    config = function ()
      require('smear_cursor').setup({})
    end
  },
  {
    "karb94/neoscroll.nvim",
    opts = {},
    config = function ()
      require('neoscroll').setup({})
    end
  }
}
