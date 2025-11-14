return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  config = function()
    require("Comment").setup()
    local ft = require("Comment.ft")
    ft.dosini = "# %s"
    ft.tsx = { "// %s", "{/* %s */}" }
    ft.conf = "# %s"
  end,
}
