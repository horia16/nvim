require("config.vim")
-- LOAD PLUGINS
require("config.lazy")


-- UNMAP <Space> SO IT ACTS ONLY AS LEADER
vim.keymap.set('n', '<Space>', '<Nop>', { silent = true })
vim.keymap.set('v', '<Space>', '<Nop>', { silent = true })


