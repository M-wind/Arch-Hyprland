vim.api.nvim_create_autocmd("FileType", {
  once = true,
  pattern = { "log" },
  callback = function()
    vim.pack.add({
      { src = "https://github.com/fei6409/log-highlight.nvim" },
    })
    require("log-highlight").setup({
      keyword = {
        error = "ERROR_MSG",
        warning = { "WARN_X", "WARN_Y", "WRN" },
        info = { "INFORMATION", "INF" },
        debug = {},
        pass = { "START", "END" },
      },
    })
  end,
})
