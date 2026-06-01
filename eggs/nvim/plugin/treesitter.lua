local filetypes = {
  "bash", "sh",
  "c_sharp", "cs",
  "cmake",
  "corn",
  "cpp",
  "css",
  "csv",
  "diff", "gitdiff",
  "gitignore",
  "go",
  "html",
  "ini", "confini", "dosini",
  "java",
  "javascript", "javascriptreact", "ecma", "ecmascript", "jsx", "js",
  "json", "jsonc",
  "kdl",
  "make", "automake",
  "nu",
  "regex",
  "rhai",
  "ron",
  "rust",
  "toml",
  "tsv",
  "tsx", "typescriptreact", "typescript.tsx",
  "typescript", "ts",
  "typescript", "typescriptreact",
  "xml", "svg",
  "yaml",
  "yuck",
  "zig",
}

local register = {
  bash = { "sh" },
  c_sharp = { "cs" },
  diff = { "gitdiff" },
  ini = { "confini", "dosini" },
  javascript = { "javascriptreact", "ecma", "ecmascript", "jsx", "js" },
  json = { "jsonc" },
  make = { "automake" },
  tsx = { "typescriptreact", "typescript.tsx" },
  typescript = { "ts" },
  xml = { "svg" },
}

vim.filetype.add({
  extension = {
    rhai = "rhai",
    log = "log",
    service = "systemd"
  },
})

for lang, ft in pairs(register) do
  vim.treesitter.language.register(lang, ft)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = filetypes,
  callback = function()
    vim.schedule(function()
      vim.treesitter.start()
    end)
  end,
})

-- vim.pack.add({
--   { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
-- })
-- require("tree-sitter-manager").setup({
--   border = "rounded",
--   auto_install = false,
--   highlight = true,
--   languages = {
--     rhai = {
--       install_info = {
--         url = "https://github.com/elkowar/tree-sitter-rhai",
--         use_repo_queries = true,
--       },
--     },
--   },
--   ensure_installed = {
--     "bash",
--     "c_sharp",
--     "make",
--     "cmake",
--     "corn",
--     "cpp",
--     "css",
--     "csv",
--     "diff",
--     "gitignore",
--     "go",
--     "html",
--     "ini",
--     "java",
--     "javascript",
--     "json",
--     "kdl",
--     "nu",
--     "regex",
--     "ron",
--     "rust",
--     "toml",
--     "tsx",
--     "typescript",
--     "xml",
--     "yaml",
--     "yuck",
--     "zig",
--   },
-- })
