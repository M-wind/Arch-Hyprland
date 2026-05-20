return {
  "neovim/nvim-lspconfig",
  event = "User FilePost",
  opts = function()
    local icons = require("utils.icons").diagnostics

    local function make_position_params()
      return function(client)
        return vim.lsp.util.make_position_params(nil, client.offset_encoding)
      end
    end

    function hover()
      local params = make_position_params()
      vim.lsp.buf_request(0, "textDocument/diagnostics", params, require("noice.lsp.hover").on_hover)
    end

    return {
      servers = {
        -- npm install -g TypeScript typescript-language-server
        -- ts_ls = require("ft.typescript").tsls,
        -- npm install -g @vtsls/language-server
        vtsls = require("ft.typescript").vtsls,
        -- npm install -g @tailwindcss/language-server
        tailwindcss = {},
        nushell = {},
        -- npm install -g vscode-langservers-extracted
        jsonls = {},
        rust_analyzer = require("ft.rust").rust_analyzer,
        -- grammar checker
        -- codebook = {},
        -- toml
        -- taplo = require("ft.toml").taplo,
      },
      diagnostics = {
        underline = true,
        update_in_insert = false,
        -- virtual_text = false,
        -- virtual_text = {
        --   spacing = 4,
        --   source = "if_many",
        --   prefix = "●",
        --   current_line = true,
        -- },
        -- virtual_lines = false,
        -- virtual_lines = { current_line = true },
        severity_sort = true,
        float = {
          header = "",
          prefix = "",
          source = "always",
          border = "rounded",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.Error,
            [vim.diagnostic.severity.WARN] = icons.Warn,
            [vim.diagnostic.severity.HINT] = icons.Hint,
            [vim.diagnostic.severity.INFO] = icons.Info,
          },
        },
      },
    }
  end,
  config = vim.schedule_wrap(function(_, opts)
    -- require("lspconfig.ui.windows").default_options.border = "rounded"
    -- diagnostics
    vim.diagnostic.config(opts.diagnostics)
    require("utils.lsp").setup()
    -- keymaps
    require("utils.lsp").on_attach(function(client, buf)
      -- vim.keymap.set({ "n", "v" }, "<leader>d", "", { desc = "+Diagnostics" })
      -- vim.keymap.set("n", "<leader>dc", vim.diagnostic.open_float, { desc = "Current Diagnostic" })
      -- vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Current Diagnostic" })
      -- vim.keymap.set("n", "<leader>dh", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
      -- vim.keymap.set("n", "<leader>dl", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
      vim.keymap.set(
        "n",
        "<leader>d",
        "<cmd>Telescope diagnostics bufnr=0<cr>",
        -- { desc = "All Diagnostic With Current Page" }
        { desc = "Diagnostics" }
      )
      vim.keymap.set("n", "gk", vim.diagnostic.open_float, { desc = "Open Diagnostic", buffer = buf })
      vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, { desc = "Code Action" })
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP Rename", buffer = buf })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = buf })
      vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "GoTo References", buffer = buf })
      vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "GoTo Definition", buffer = buf })
      vim.keymap.set(
        "n",
        "gs",
        "<cmd>Telescope lsp_document_symbols<cr>",
        { desc = "Lsp Current Symbols", buffer = buf }
      )
      vim.keymap.set(
        "n",
        "gS",
        "<cmd>Telescope lsp_workspace_symbols<cr>",
        { desc = "Lsp Current Workspace Symbols", buffer = buf }
      )
    end)

    -- -- Reference
    -- require("utils.lsp").on_supports_method("textDocument/references", function(_, buf)
    -- end)
    --
    -- -- Definition
    -- require("utils.lsp").on_supports_method("textDocument/definition", function(_, buf)
    -- end)
    --
    -- -- Symbols
    -- require("utils.lsp").on_supports_method("textDocument/documentSymbol", function(_, buf)
    -- end)

    -- inlay hints
    require("utils.lsp").on_supports_method("textDocument/inlayHint", function(_, buf)
      vim.keymap.set("n", "<leader>i", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = "Toggle Inlay Hit", buffer = buf })
    end)

    -- codeLens
    require("utils.lsp").on_supports_method("textDocument/codeLens", function(_, buffer)
      vim.lsp.codelens.refresh()
      -- neovim 0.12+
      -- vim.lsp.codelens.enable(true, { bufnr = buffer })
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = buffer,
        callback = vim.lsp.codelens.refresh,
        -- neovim 0.12+
        -- callback = vim.lsp.codelens.get,
      })
    end)

    -- capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- nvim 0.11+ Don't need
    -- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
    -- capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
    for server, set in pairs(opts.servers) do
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = capabilities,
      }, set or {})
      vim.lsp.config(server, server_opts)
      vim.lsp.enable(server)
    end
  end),
}
