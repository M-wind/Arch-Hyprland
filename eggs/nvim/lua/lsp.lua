vim.keymap.del("n", "grn")
vim.keymap.del({ "n", "x" }, "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grt")
vim.keymap.del("n", "gO")
vim.keymap.del("n", "grx")

local icons = require("utils.icons").diagnostics
local diagnostics = {
  underline = true,
  update_in_insert = false,
  virtual_text = false,
  -- virtual_text = {
  --   spacing = 4,
  --   source = "if_many",
  --   prefix = "●",
  --   current_line = true,
  -- },
  virtual_lines = false,
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
}

require("utils.lazyload").on_vim_enter(function()
  -- diagnostics
  vim.diagnostic.config(diagnostics)

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buf = args.buf
      vim.keymap.set("n", "<leader>d", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Diagnostics" })
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
      local clent_id = args.data.client_id
      local client = vim.lsp.get_client_by_id(clent_id)
      if client and client:supports_method("textDocument/inlayHint") then
        vim.keymap.set("n", "<leader>i", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "Toggle Inlay Hit", buffer = buf })
      end
      if client and client:supports_method("textDocument/codeLens") then
        vim.lsp.codelens.enable(true, { bufnr = buf })
        -- vim.keymap.set("n", "<leader>e", function()
        --   vim.lsp.codelens.run({ client_id = args.data.client_id })
        -- end, { desc = "Code Run", buffer = buf })
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          buffer = buf,
          callback = function()
            vim.lsp.codelens.get({ bufnr = buf, client_id = clent_id })
          end,
        })
      end
    end,
  })

  vim.lsp.enable({
    "rust_analyzer",
    "bacon_ls",
    "vtsls",
    "tailwindcss",
    "jsonls",
    "nushell",
    -- "emmylua_ls",
  })
end)
