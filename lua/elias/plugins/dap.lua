return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{ "<F5>", function() require("dap").continue() end, desc = "Debug: Continue" },
			{ "<F10>", function() require("dap").step_over() end, desc = "Debug: Step over" },
			{ "<F11>", function() require("dap").step_into() end, desc = "Debug: Step into" },
			{ "<F12>", function() require("dap").step_out() end, desc = "Debug: Step out" },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle breakpoint" },
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Conditional breakpoint" },
			{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "Debug: Toggle REPL" },
			{ "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
			{ "<leader>dq", function() require("dap").terminate(); require("dapui").close() end, desc = "Debug: Terminate" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.before.attach.dapui_config = function() dapui.open() end
			dap.listeners.before.launch.dapui_config = function() dapui.open() end
			dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
			dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

			dap.adapters.gdb = {
				type = "executable",
					command = "gdb",
					args = { "--interpreter=dap" },
			}
			dap.configurations.c = {
				{
					name = "Launch executable (GDB)",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Executable path: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
					args = {},
					externalTerminal = false,
				},
			}
			dap.configurations.cpp = dap.configurations.c
			dap.configurations.cuda = dap.configurations.c
		end,
	},
}
