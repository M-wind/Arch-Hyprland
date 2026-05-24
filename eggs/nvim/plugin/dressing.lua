require("utils.lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = "https://github.com/stevearc/dressing.nvim" },
  })
  require("dressing").setup({
    input = {
      mappings = {
        n = { ["<C-q>"] = "Close" },
        i = { ["<C-q>"] = "Close", ["<C-c>"] = false },
      },
    },
  })
end)
