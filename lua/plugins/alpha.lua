return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	enabled = true,
	init = false,
	opts = function()
		local dashboard = require("alpha.themes.dashboard")
		local logo = [[
  ⠀⠀⠀⠀⠀⠀⠀⣤⣤⣤⣄⣀   ⠀⠀⠀⣀⣀⣀⣀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⢰⡏⢻⣫⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⠟⣿⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⡐⡄⣸⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⣿⠀⠀⠀⠀⠀
  ⠀⠀⣀⠠⢝⡜⣿⣿⡟⢉⣭⡝⢿⣿⣿⣿⡟⣭⣭⠉⢻⣿⡿⡠⠒⠀⠀⠀
  ⡴⣟⣿⣻⣆⢰⣿⣿⠀⢸⣿⣿⢸⣿⣿⣿⠙⣿⣿⠇⠈⣿⣿⠱⠭⠄⠀⠀
  ⢷⣿⡀⣸⣿⡞⣿⣿⣄⠀⠉⠁⣼⣿⢿⣿⣧⠈⠁⠀⣰⣿⣿⣠⣴⣶⣦⣄
  ⠈⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠙⠒⠓⠒⠛⠛⠛⠛⠛⠛⠓⠻⡏⣿⣿⠿

░▒█▄░▒█░█▀▀░▄▀▀▄░▒█░░▒█░░▀░░█▀▄▀█
░▒█▒█▒█░█▀▀░█░░█░░▒█▒█░░░█▀░█░▀░█
░▒█░░▀█░▀▀▀░░▀▀░░░░▀▄▀░░▀▀▀░▀░░▒▀
    ]]

		dashboard.section.header.val = vim.split(logo, "\n")
    -- stylua: ignore
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
      dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
      dashboard.button("s", "" .. " Sessions", "<cmd> Telescope persisted<cr>"),
      dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
    }
		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaShortcut"
		end
		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"
		dashboard.section.footer.opts.hl = "AlphaFooter"
		dashboard.opts.layout[1].val = 8
		return dashboard
	end,
	config = function(_, dashboard)
		require("alpha").setup(dashboard.opts)
	end,
}
