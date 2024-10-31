return {
    "mfussenegger/nvim-dap",
    dependencies = {
        { "rcarriga/nvim-dap-ui", dependencies = "nvim-neotest/nvim-nio" },
        "theHamsta/nvim-dap-virtual-text",
    },
    -- enabled = false,
    config = function()
        local PROGRAM = "test"
        local ARGS = { "test_file1.txt" }

        -- Debugger installation location
        local MASON = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/"
        local CODELLDB = MASON .. "codelldb/codelldb"

        local dap = require("dap")
        local dapui = require("dapui")

        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = CODELLDB,
                args = { "--port", "${port}" },
            },
        }

        local CODELLDB_CONFIG = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = PROGRAM,
                args = ARGS,
                -- program = function()
                --     return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                -- end,
                -- args = function()
                --     local args = {}
                --     vim.ui.input({ prompt = "Enter command-line arguments: " }, function(input)
                --         args = vim.split(input, " ")
                --     end)
                --     return args
                -- end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }

        dap.configurations.cpp = CODELLDB_CONFIG
        dap.configurations.c = CODELLDB_CONFIG
        dap.configurations.rust = CODELLDB_CONFIG

        dap.adapters.firefox = {
            type = "executable",
            command = "node",
            args = { vim.fn.stdpath("data") .. "/dap/vscode-firefox-debug/dist/adapter.bundle.js" },
        }

        dap.configurations.typescript = {
            {
                name = "Debug with Firefox",
                type = "firefox",
                request = "launch",
                reAttach = true,
                url = "http://localhost:3000",
                webRoot = "${workspaceFolder}",
                firefoxExecutable = "/Applications/Firefox.app/Contents/MacOS/firefox",
            },
        }

        require("nvim-dap-virtual-text").setup({})

        dapui.setup({
            icons = { expanded = "▾", collapsed = "▸" },
            mappings = {
                -- Use a table to apply multiple mappings
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            layouts = {
                {
                    -- You can change the order of elements in the sidebar
                    elements = {
                        -- { id = "breakpoints", size = 0.25 },
                        { id = "stacks", size = 0.30 },
                        { id = "scopes", size = 0.35 },
                        { id = "watches", size = 0.35 },
                    },
                    size = 40,
                    position = "left",
                },
                {
                    elements = { "repl" },
                    size = 10,
                    position = "bottom",
                },
            },
            floating = {
                max_height = nil,
                max_width = nil, -- Floats will be treated as percentage of your screen.
                border = "single", -- Border style. Can be "single", "double" or "rounded"
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            windows = { indent = 1 },
        })

        vim.fn.sign_define("DapBreakpoint", { text = "●" })
        vim.fn.sign_define("DapStopped", { text = "" })

        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>dn", dap.continue)
        vim.keymap.set("n", "<leader>dh", dapui.eval)

        -- Emergency Hard Reset
        vim.keymap.set("n", "<leader>d_", function()
            dap.disconnect()
            dap.close()
            dap.run_last()
        end)

        -- Misc Keybinds, probably not used
        vim.keymap.set("n", "<leader>dk", dap.up)
        vim.keymap.set("n", "<leader>dj", dap.down)
        vim.keymap.set("n", "<leader>ds", dap.terminate)
        vim.keymap.set("n", "<leader>dt", dapui.toggle)
        vim.keymap.set("n", "<leader>dv", dapui.float_element)

        -- Automatic dap-ui
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

        -- vim.keymap.set("n", "<S-k>", dap.step_out)
        -- vim.keymap.set("n", "<S-l>", dap.step_into)
        -- vim.keymap.set("n", "<S-j>", dap.step_over)

        -- vim.keymap.set("n", "<leader>B", function()
        --     dap.set_breakpoint(vim.fn.input("Breakpoint Condition: "))
        -- end, { silent = true })
    end,
}
