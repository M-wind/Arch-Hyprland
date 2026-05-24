vim.filetype.add({
  extension = {
    rhai = "rhai",
    log = "log",
    dosini = "dosini",
  },
})

vim.pack.add({
  { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
})
vim.treesitter.language.register("hyprlang", "conf")
vim.treesitter.language.register("hyprlang", "dosini")

require("tree-sitter-manager").setup({
  border = "rounded",
  auto_install = false,
  highlight = true,
  languages = {
    rhai = {
      install_info = {
        url = "https://github.com/elkowar/tree-sitter-rhai",
        use_repo_queries = true,
      }
    }
  },
  ensure_installed = {
    "bash",
    "c_sharp",
    "make",
    "cmake",
    "corn",
    "cpp",
    "css",
    "csv",
    "diff",
    "gitignore",
    "go",
    "html",
    "hyprlang",
    "java",
    "javascript",
    "json",
    "kdl",
    "nu",
    "regex",
    "ron",
    "rust",
    "toml",
    "tsx",
    "typescript",
    "xml",
    "yaml",
    "yuck",
    "zig",
  },
})
