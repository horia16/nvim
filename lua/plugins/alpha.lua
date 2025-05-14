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

    local colors = {
      "#ff5555", -- red
      "#f1fa8c", -- yellow
      "#50fa7b", -- green
      "#8be9fd", -- cyan
      "#bd93f9", -- purple
      "#ff79c6", -- pink
      "#9aedfe", -- blue
    }

    local random_color = colors[math.random(#colors)]
    vim.api.nvim_set_hl(0, "AlphaLogo", { fg = random_color })

    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.header.opts.hl = "AlphaLogo"

    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file", "<cmd> Telescope find_files <cr>"),
      dashboard.button("l", "󰒲  Lazy", "<cmd> Lazy <cr>"),
      dashboard.button("u", "󱐥  Update plugins", "<cmd>Lazy sync<CR>"),
      dashboard.button("t", "  Install language tools", "<cmd>Mason<CR>"),
      dashboard.button("s", "  Sessions", "<cmd> Telescope persisted<cr>"),
      dashboard.button("q", "  Quit", "<cmd> qa <cr>"),
    }

    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end

    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 8

    return dashboard
  end,
  config = function(_, dashboard)
    require("alpha").setup(dashboard.opts)
  end,
}
