-- vim.schedule(function()
-- end)
require("utils.lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = "https://github.com/M-wind/simpleindent.nvim" },
  })
  require("simpleindent").setup({ exclude = { filetype = { "dashboard" } } })
end)
