require("utils.lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = "https://github.com/numToStr/Comment.nvim" },
  })
  require("Comment").setup()
  local ft = require("Comment.ft")
  ft.rhai = "// %s"
  ft.systemd = "# %s"
end)
