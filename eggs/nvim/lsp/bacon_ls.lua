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
