return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets", "bydlw98/blink-cmp-env", "moyiz/blink-emoji.nvim" },
  event = "InsertEnter",
  version = "*",
  opts = {
    enabled = function()
      return not vim.tbl_contains({ "nofile", "prompt" }, vim.bo.buftype)
    end,
    keymap = {
      preset = "none",
      -- ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      -- ["<C-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<C-j>"] = { "select_next", "snippet_forward", "fallback" },
      ["<C-k>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-h>"] = { "hide" },
      -- ["<C-w>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-d>"] = { "scroll_documentation_up", "fallback" },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "env", "emoji" },
      default = { "lsp", "path", "snippets", "buffer", "env", "emoji" },
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
        emoji = {
          module = "blink-emoji",
          name = "emoji",
          score_offset = 15, -- Tune by preference
          opts = {
            insert = true, -- Insert emoji (default) or complete its name
            ---@type string|table|fun():table
            trigger = function()
              return { ":" }
            end,
          },
          -- should_show_items = function()
          --   return vim.tbl_contains(
          --     -- Enable emoji completion only for git commits and markdown.
          --     -- By default, enabled for all file-types.
          --     { "gitcommit", "markdown" },
          --     vim.o.filetype
          --   )
          -- end,
        },
      },
    },
    -- fuzzy = { implementation = "prefer_rust_with_warning" },
    fuzzy = { implementation = "rust" },
    cmdline = { enabled = false },
    completion = {
      keyword = { range = "full" },
      list = { selection = { preselect = true, auto_insert = true } },
      menu = {
        border = "rounded",
        -- winhighlight = "Noraml:NormalFloat,CursorLine:IncSearch",
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
                return require("utils.icons").cmp[ctx.kind]
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
  },
}
