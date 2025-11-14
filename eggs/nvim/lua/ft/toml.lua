local M = {}

M.taplo = {
  workspace_required = false,
  root_dir = function(_, on_dir)
    on_dir(vim.fn.getcwd())
  end,
}

return M
