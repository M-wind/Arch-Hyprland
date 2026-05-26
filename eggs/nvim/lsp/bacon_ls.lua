-- https://github.com/crisidev/bacon-ls
-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/bacon_ls.lua
return {
  cmd = { "bacon-ls" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml" },
  settings = {
    bacon_ls = {
      backend = "cargo",
      cargo = {
        command = "check",
        checkOnSave = true,
      },
    },
  },
}
