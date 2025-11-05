local M = {}

M.formatexpr = function()
  return require("conform").formatexpr()
end

M.foldtext = function()
  local pos = vim.v.foldstart
  local line = vim.api.nvim_buf_get_lines(0, pos - 1, pos, false)[1]
  local cline = vim.v.foldend - pos
  return { { line, "@property" }, { " 󰁂..." .. cline, "@constructor" } }
end

M.tab_width_change = function(width)
  vim.opt.tabstop = width
  vim.opt.shiftwidth = width
  vim.opt.softtabstop = width
end

M.path = function(exe, configname)
  local re = vim.fn.exepath(exe)
  re = vim.fn.fnamemodify(re, ":h")
  return ("%s/%s"):format(re, configname)
end

return M
