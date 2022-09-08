return {
  {
    "simrat39/rust-tools.nvim",
    after = "mason-lspconfig.nvim",
    config = function()
      require("rust-tools").setup {
        server = astronvim.lsp.server_settings "rust_analyzer",
        opts = {
          dap = {
            adapter = require("rust-tools.dap").get_codelldb_adapter(
              "/usr/lib/codelldb/adapter/codelldb",
              "/usr/lib/codelldb/lldb/lib/liblldb.so"
            ),
          },
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"

      -- csharp config
      dap.adapters.coreclr = {
        type = "executable",
        command = "/home/popcorn/.local/share/nvim/mason/bin/netcoredbg",
        args = { "--interpreter=vscode" },
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function() return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file") end,
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    requires = { "nvim-dap", "rust-tools.nvim" },
    config = function()
      local dapui = require "dapui"
      dapui.setup {}

      local dap = require "dap"
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- csharp config
      dap.adapters.coreclr = {
        type = "executable",
        command = "/home/popcorn/.local/share/nvim/mason/bin/netcoredbg",
        args = { "--interpreter=vscode" },
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function() return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file") end,
        },
      }

      local map = vim.api.nvim_set_keymap
      map("n", "<F5>", ":lua require('dap').continue()<cr>", { desc = "Continue" })
      map("n", "<F10>", ":lua require('dap').step_over()<cr>", { desc = "Step over" })
      map("n", "<F11>", ":lua require('dap').step_into()<cr>", { desc = "Step into" })
      map("n", "<F12>", ":lua require('dap').step_out()<cr>", { desc = "Step out" })
      map("n", "<leader>bp", ":lua require('dap').toggle_breakpoint()<cr>", { desc = "Toggle breakpoint" })
      map(
        "n",
        "<leader>Bp",
        ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
        { desc = "Set conditional breakpoint" }
      )
      map(
        "n",
        "<leader>lp",
        ":lua require('dap').set_breakpoint(nill, nil, vim.fn.input('Logpoint message: '))<cr>",
        { desc = "Set logpoint" }
      )
      map("n", "<leader>rp", ":lua require('dap').repl.open()<cr>", { desc = "Open REPL" })
      map("n", "<leader>RR", ":lua require('dap').run_last()<cr>", { desc = "Run last debugged program" })
      map("n", "<leader>XX", ":lua require('dap').terminate()<cr>", { desc = "Terminate program being debugged" })
      map("n", "<leader>du", ":lua require('dap').up()<cr>", { desc = "Up one frame" })
      map("n", "<leader>dd", ":lua require('dap').down()<cr>", { desc = "Down one frame" })
    end,
  },
  {
    "Saecki/crates.nvim",
    after = "nvim-cmp",
    config = function()
      require("crates").setup()

      local cmp = require "cmp"
      local config = cmp.get_config()
      table.insert(config.sources, { name = "crates", priority = 1100 })
      cmp.setup(config)

      local map = vim.api.nvim_set_keymap
      map("n", "<leader>Ct", ":lua require('crates').toggle()<cr>", { desc = "Toggle extra crates.io information" })
      map("n", "<leader>Cr", ":lua require('crates').reload()<cr>", { desc = "Reload information from crates.io" })
      map("n", "<leader>CU", ":lua require('crates').upgrade_crate()<cr>", { desc = "Upgrade a crate" })
      map("v", "<leader>CU", ":lua require('crates').upgrade_crates()<cr>", { desc = "Upgrade selected crates" })
      map("n", "<leader>CA", ":lua require('crates').upgrade_all_crates()<cr>", { desc = "Upgrade all crates" })
    end,
  },
}
