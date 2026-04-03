local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = "VeryLazy",
  -- event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- require("nvim-treesitter.install").compilers = { "gcc" }
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c_sharp",
        "cpp",
        "corn",
        "css",
        "csv",
        "diff",
        "gitignore",
        "go",
        "html",
        "hyprlang",
        "javascript",
        "java",
        "json",
        "jsonc",
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
    vim.treesitter.language.register("hyprlang", "conf")
    vim.treesitter.language.register("javascript", "rhai")
  end,
  vim.filetype.add({
    extension = {
      rhai = "rhai",
      log = "log",
    },
  }),
}

local ts_autotag = {
  "windwp/nvim-ts-autotag",
  event = "User FilePost",
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
    })
  end,
}

return { treesitter, ts_autotag }
