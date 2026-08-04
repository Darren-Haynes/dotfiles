-- Custom DAP configurations for Electron and JavaScript/TypeScript

---@type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    -- Use config function parameter to extend, not destroy, AstroNvim's core setup
    config = function(plugin, opts)
      -- 1. Run AstroNvim's default DAP configuration first (safely boots UI & keys)
      require "astronvim.plugins.configs.nvim-dap"(plugin, opts)

      local dap = require "dap"

      -- 2. Configure your specific JS Adapter Server with Electron protocol patch
      local js_adapter_config = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        },
        enrich_config = function(config, on_config)
          local final_config = vim.deepcopy(config)
          local cwd = vim.fn.getcwd()

          -- Safely substitute absolute workspace paths
          if final_config.runtimeExecutable then
            final_config.runtimeExecutable = final_config.runtimeExecutable:gsub("%%${workspaceFolder}", cwd)
          end
          if final_config.cwd then final_config.cwd = final_config.cwd:gsub("%%${workspaceFolder}", cwd) end
          if final_config.windows and final_config.windows.runtimeExecutable then
            final_config.windows.runtimeExecutable =
              final_config.windows.runtimeExecutable:gsub("%%${workspaceFolder}", cwd)
          end

          -- FORCE THE INTERNAL PROTOCOL TYPE TO PWA-NODE
          -- This prevents the background server from dropping connection when spawning Electron
          if final_config.type == "node" then final_config.type = "pwa-node" end

          on_config(final_config)
        end,
      }

      -- 3. Register your adapters cleanly
      dap.adapters["pwa-node"] = js_adapter_config
      dap.adapters["node"] = js_adapter_config
    end,
  },
}
