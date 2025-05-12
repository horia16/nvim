local function has_config_upwards(start_path, target_files)
	local Path = require("plenary.path")
	local path = Path:new(start_path)

	while path.filename ~= "/" do
		for _, file in ipairs(target_files) do
			if Path:new(path, file):exists() then
				return true
			end
		end
		path = path:parent()
	end

	return false
end

local function has_eslint_config_upwards(start_path)
	return has_config_upwards(start_path, {
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.json",
		".eslintrc.yaml",
		".eslintrc.yml",
		"eslint.config.js",
		"eslint.config.mjs",
	})
end

local function has_gemfile_upwards(start_path)
	return has_config_upwards(start_path, { "Gemfile" })
end

return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
      default_offset_encoding = "utf-16",
      capabilities = {
        offsetEncoding = { "utf-16" },
      },
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
				null_ls.builtins.diagnostics.rubocop.with({
					command = "bundle",
					args = { "exec", "rubocop", "--format", "json", "--force-exclusion", "--stdin", "$FILENAME" },
					to_stdin = true,
					condition = function()
						local buf_path = vim.api.nvim_buf_get_name(0)
						local start_dir = vim.fn.fnamemodify(buf_path, ":p:h")
						return has_gemfile_upwards(start_dir)
					end,
				}),
				null_ls.builtins.formatting.rubocop.with({
					command = "bundle",
					args = { "exec", "rubocop", "--auto-correct", "--stdin", "$FILENAME", "--stdout", "--stderr", "--format", "quiet" },
					to_stdin = true,
					condition = function()
						local buf_path = vim.api.nvim_buf_get_name(0)
						local start_dir = vim.fn.fnamemodify(buf_path, ":p:h")
						return has_gemfile_upwards(start_dir)
					end,
				}),
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
