return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local lga = require("telescope").extensions.live_grep_args

    telescope.load_extension("live_grep_args")

    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', lga.live_grep_args, { desc = 'Telescope live grep (args)' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>fs', function()
      telescope.extensions.persisted.persisted()
    end, { desc = 'Telescope sessions' })
  end
}
