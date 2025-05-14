return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		dapui.setup({})

		-- Debugger keymaps with descriptions
		vim.keymap.set("n", "<Leader>dt", function()
			dap.toggle_breakpoint()
		end, { desc = "Toggle breakpoint" })

		vim.keymap.set("n", "<Leader>dc", function()
			dap.continue()
		end, { desc = "Start/continue debugging" })

		vim.keymap.set("n", "<Leader>do", function()
			dap.step_over()
		end, { desc = "Step over" })

		vim.keymap.set("n", "<Leader>di", function()
			dap.step_into()
		end, { desc = "Step into" })

		vim.keymap.set("n", "<Leader>dO", function()
			dap.step_out()
		end, { desc = "Step out" })

		-- Auto open/close dap-ui on events
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end,
}
