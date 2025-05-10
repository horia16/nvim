return {
  "olimorris/persisted.nvim",
  event = "BufReadPre",
  opts = {
  },
  config = function ()
    require("persisted").setup({
      autosave = true,
      autoload = true,
      follow_cwd = true,
      allowed_dirs = nil,
      ignored_dirs = nil,
      use_git_branch = false,
      save_dir = vim.fn.stdpath("data") .. "/sessions/",

      session_formatter = function()
        -- Return a clean session name
        return vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      end,
    })
    require("telescope").load_extension("persisted")
  end
}
