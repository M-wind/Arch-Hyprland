local M = {}

M.rust_analyzer = {
  -- settings = {
  --   ["rust-analyzer"] = {
  --     diagnostics = { enable = false },
  --     checkOnSave = { enable = false },
  --   },
  -- },
}

M.bacon_ls = {
  workspace_required = false,
  root_dir = function(_, on_dir)
    on_dir(vim.fn.getcwd())
  end,
  settings = {
    init_options = {
      updateOnSave = true,
      updateOnSaveWaitMillis = 1000,
    },
  },
}

M.dap = function(dap)
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = "/home/zwind/app/debugger/codelldb/adapter/codelldb",
      args = { "--port", "${port}" },
    },
  }
  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
  dap.configurations.c = dap.configurations.rust
  dap.configurations.cpp = dap.configurations.rust
end

return M
