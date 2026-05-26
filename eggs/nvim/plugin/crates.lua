vim.api.nvim_create_autocmd("FileType", {
  once = true,
  pattern = { "toml" },
  callback = function(v)
    require("utils.lazyload").on_vim_enter(function()
      vim.pack.add({
        { src = "https://github.com/saecki/crates.nvim" },
      })
      require("crates").setup({
        popup = {
          autofocus = true,
          show_dependency_version = false,
          border = "rounded",
          keys = {
            hide = { "<C-q>", "<esc>" },
            open_url = { "<cr>" },
            select = { "<cr>" },
            select_alt = {},
            toggle_feature = { "<cr>" },
            copy_value = {},
            goto_item = {},
            jump_forward = {},
            jump_back = {},
          },
        },
        completion = {
          blink = {
            use_custom_kind = true,
            -- kind_text = {
            --   version = "Version",
            --   feature = "Feature",
            -- },
            -- kind_highlight = {
            --   version = "BlinkCmpKindVersion",
            --   feature = "BlinkCmpKindFeature",
            -- },
            kind_icon = {
              version = "",
              feature = "",
            },
          },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })
    end)
  end,
})
