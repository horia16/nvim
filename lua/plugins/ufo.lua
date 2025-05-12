return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  config = function()
    -- Set fold options
    vim.o.foldcolumn = '1' -- '0' to disable
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = false

    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "lsp", "indent" } -- fallbacks
      end
    })
    -- Open all folds
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })

    -- Close all folds
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })

    -- Open folds except kinds like `comment`, `import`, etc.
    vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, { desc = 'Open folds except certain kinds' })

    -- Close folds with level higher than the current 
    vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, { desc = 'Close folds deeper than current' })

  end
}
