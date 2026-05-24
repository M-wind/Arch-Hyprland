local M = {}

local vim_enter_queue = {}

local start = function(queue)
  for _, entry in ipairs(queue) do
    vim.schedule(entry.fn)
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    if vim_enter_queue then
      start(vim_enter_queue)
      vim_enter_queue = nil
    end
  end,
})

M.on_vim_enter = function(fn)
  table.insert(vim_enter_queue, { fn = fn })
end

return M
