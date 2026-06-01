vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
  once = true,
  callback = function()
    vim.pack.add({
      { src = "https://github.com/rafamadriz/friendly-snippets" },
      { src = "https://github.com/bydlw98/blink-cmp-env" },
      -- { src = "https://github.com/saghen/blink.lib" },
      { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },
    })
    local blink = require("blink.cmp")
    -- blink.build():wait(60000)
    blink.setup({
      enabled = function()
        return not vim.tbl_contains({ "nofile", "prompt" }, vim.bo.buftype)
      end,
      keymap = {
        preset = "none",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<C-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-j>"] = { "select_next", "snippet_forward", "fallback" },
        ["<C-k>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-e>"] = { "hide" },
        -- ["<C-w>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-d>"] = { "scroll_documentation_up", "fallback" },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "omni", "env" },
        providers = {
          env = {
            name = "env",
            module = "blink-cmp-env",
            --- @type blink-cmp-env.Options
            opts = {
              -- item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
              item_kind = 6,
              show_braces = false,
              show_documentation_window = true,
            },
          },
        },
      },
      -- fuzzy = { implementation = "prefer_rust_with_warning" },
      fuzzy = { implementation = "rust" },
      cmdline = {
        enabled = true,
        keymap = {
          preset = "none",
          ["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
          ["<C-Tab>"] = { "show_and_insert_or_accept_single", "select_prev" },
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<CR>"] = { "fallback" },
          ["<C-e>"] = { "cancel", "fallback" },
        },
        sources = { "buffer", "cmdline" },
        completion = {
          trigger = {
            show_on_blocked_trigger_characters = {},
            show_on_x_blocked_trigger_characters = {},
          },
          list = {
            selection = {
              preselect = false,
              auto_insert = true,
            },
          },
          menu = {
            auto_show = function(ctx, _)
              return ctx.mode == "cmdwin"
            end,
          },
          ghost_text = { enabled = true },
        },
      },
      completion = {
        keyword = { range = "full" },
        list = { selection = { preselect = true, auto_insert = true } },
        menu = {
          border = "rounded",
          -- winhighlight = "Noraml:NormalFloat, CursorLine:IncSearch",
          draw = {
            align_to = "label",
            -- columns = { { "kind_icon" }, { "label", "kind", gap = 1 } },
            columns = { { "kind_icon" }, { "label", "source_name", gap = 1 } },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  -- return require("utils.icons").cmp[ctx.kind] or ""
                  local tailwindColor = require("utils.theme").tailwindColor
                  if ctx.kind == "Color" then
                    tailwindColor[ctx.kind_hl] = ctx.item.documentation
                  end
                  return require("utils.icons").cmp[ctx.kind] or ctx.kind_icon
                end,
              },
              -- kind = {
              --   ellipsis = false,
              --   text = function(ctx)
              --     return "(" .. ctx.kind .. ")"
              --   end,
              --   highlight = "BlinkCmpSource",
              -- },
              -- source_name = {
              --   ellipsis = false,
              --   text = function(ctx)
              --     -- local kind = require("utils.icons").cmp[ctx.kind] and ctx.kind or "Tips"
              --     -- return "(" .. kind .. ")"
              --     return "(" .. ctx.source_name .. ")"
              --   end,
              --   highlight = "BlinkCmpSource",
              -- },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 300,
          window = { border = "rounded" },
        },
      },
      signature = { enabled = false, window = { border = "rounded" } },
    })
  end,
})
