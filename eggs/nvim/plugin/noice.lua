require("utils.lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/rcarriga/nvim-notify" },
    { src = "https://github.com/folke/noice.nvim" },
  })

  require("notify").setup({ stages = "static", timeout = 3000 })
  require("noice").setup({
    -- cmdline = {
    --   enabled = true,
    --   view = "cmdline_popup",
    --   opts = {
    --     position = "50%",
    --   },
    -- },
    commands = {
      history = { view = "popup" },
      all = { view = "popup" },
    },
    views = {
      messages = { view = "popup" },
      popup = { close = { keys = "<c-q>" } },
      split = { close = { leys = "<c-q>" } },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = false,
      },
      hover = {
        enabled = true,
        silent = true,
      },
    },
    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
  })

  vim.keymap.set({ "n", "v" }, "<leader>n", "", { desc = "+Noice" })
  vim.keymap.set({ "n", "v" }, "<leader>nl", function()
    require("noice").cmd("last")
  end, { desc = "Noice Last Message" })

  vim.keymap.set({ "n", "v" }, "<leader>nh", function()
    require("noice").cmd("telescope")
  end, { desc = "Noice History" })

  vim.keymap.set({ "n", "v" }, "<leader>na", function()
    require("noice").cmd("all")
  end, { desc = "Noice All" })

  vim.keymap.set({ "n", "v" }, "<leader>nd", function()
    require("noice").cmd("dismiss")
  end, { desc = "Dismiss All" })
end)
