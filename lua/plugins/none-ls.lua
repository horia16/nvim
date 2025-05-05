local function has_eslint_config_upwards(start_path)
	local config_files = {
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.json",
		".eslintrc.yaml",
		".eslintrc.yml",
		"eslint.config.js",
		"eslint.config.mjs",
	}

	local Path = require("plenary.path")
	local path = Path:new(start_path)

	while path.filename ~= "/" do
		for _, config in ipairs(config_files) do
			if Path:new(path, config):exists() then
				return true
			end
		end
		path = path:parent()
	end

	return false
end

return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd.with({
					filetypes = { "javascript", "typescript", "astro", "json", "css", "html" },
				}),
				null_ls.builtins.completion.spell,
				require("none-ls.diagnostics.eslint_d").with({
					condition = function()
						local buf_path = vim.api.nvim_buf_get_name(0)
						local start_dir = vim.fn.fnamemodify(buf_path, ":p:h")
						return has_eslint_config_upwards(start_dir)
					end,
				}),
				null_ls.builtins.diagnostics.rubocop,
				null_ls.builtins.formatting.rubocop,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
