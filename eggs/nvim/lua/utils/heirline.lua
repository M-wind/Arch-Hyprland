local M = {}

M.buflist_cache = {}

local get_bufs = function()
  return vim.tbl_filter(function(bufnr)
    return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
  end, vim.api.nvim_list_bufs())
end

-- vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
  callback = function()
    vim.schedule(function()
      local buffers = get_bufs()
      for i, v in ipairs(buffers) do
        M.buflist_cache[i] = v
      end
      for i = #buffers + 1, #M.buflist_cache do
        M.buflist_cache[i] = nil
      end

      if #M.buflist_cache > 1 then
        vim.o.showtabline = 2
      elseif vim.o.showtabline ~= 1 then
        vim.o.showtabline = 1
      end
      -- vim.o.showtabline = require("nvim-tree.api").tree.is_visible() and 2 or 1
    end)
  end,
})

-- local CLose_TabPage = function()
--   local tabpages = vim.api.nvim_list_tabpages()
--   if #tabpages > 1 then
--     for _, page in ipairs(tabpages) do
--       local wins = vim.api.nvim_tabpage_get_var(page)
--       vim.print(wins)
--       -- if #wins == 0 then
--       --   vim.api.nvim_tabpage_del_var(page)
--       -- end
--     end
--   end
-- end

M.Close_Current = function()
  vim.cmd("Bdelete")
end

M.Close_Buf_All = function()
  for _, _ in ipairs(M.buflist_cache) do
    vim.cmd("Bdelete")
  end
end

M.Close_Buf_Except_Current = function()
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(M.buflist_cache) do
    if bufnr ~= current then
      vim.cmd(("silent! %s %d"):format("Bdelete", bufnr))
    end
  end
end

M.Close_Buf_Right = function()
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(M.buflist_cache) do
    if bufnr > current then
      vim.cmd(("silent! %s %d"):format("Bdelete", bufnr))
    end
  end
end

M.Close_Buf_Left = function()
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(M.buflist_cache) do
    if bufnr < current then
      vim.cmd(("silent! %s %d"):format("Bdelete", bufnr))
    end
  end
end

M.settings = {
  encoding = true,
  diagnostics = true,
}

return M
