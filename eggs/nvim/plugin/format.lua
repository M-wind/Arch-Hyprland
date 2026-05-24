local load = function()
  local path = require("utils.tool").path
  require("conform").setup({
    log_level = vim.log.levels.DEBUG,
    default_format_opts = {
      async = false,
      -- quiet = false,
      lsp_format = "fallback",
      timeout_ms = 5000,
    },
    formatters = {
      stylua = {
        prepend_args = { "-f", path("stylua", "stylua.toml") },
      },
      biome = {
        append_args = { ("--config-path=%s"):format(path("biome", "biome.json")) },
      },
      -- oxfmt = {
      --   inherit = false,
      --   command = "oxfmt",
      --   args = { "-c", path("oxfmt", "oxfmt.json"), "$FILENAME" }
      -- },
      taplo = {
        append_args = { "-c", path("taplo", "taplo.toml") },
      },
      yamlfmt = {
        prepend_args = { "-conf", path("yamlfmt", "yamlfmt.yaml") },
      },
      markup_fmt = {
        inherit = false,
        command = "markup_fmt",
        args = { "-c", path("markup_fmt", "markup_fmt.json"), "format", "$FILENAME" },
      },
      malva = {
        inherit = false,
        command = "malva",
        args = { "-c", path("malva", "malva.json"), "format", "$FILENAME" },
      },
      fmtron = {
        inherit = false,
        command = "fmtron",
        args = { "-d", "-w", "80", "-i", "$FILENAME" },
      },
    },
    formatters_by_ft = {
      javascript = { "biome" },
      typescript = { "biome" },
      typescriptreact = { "biome", "rustywind" },
      javascriptreact = { "biome", "rustywind" },
      json = { "biome" },
      jsonc = { "biome" },
      graphql = { "biome" },
      -- javascript = { "oxfmt" },
      -- typescript = { "oxfmt" },
      -- typescriptreact = { "oxfmt" },
      -- javascriptreact = { "oxfmt" },
      -- json = { "oxfmt" },
      -- jsonc = { "oxfmt" },
      -- graphql = { "oxfmt" },
      yaml = { "yamlfmt" },
      toml = { "taplo" },
      lua = { "stylua" },
      sh = { "shfmt" },
      rust = { "rustfmt" },
      kdl = { "kdlfmt" },
      -- markdown = { "dprint" },
      svg = { "markup_fmt" },
      xml = { "markup_fmt" },
      html = { "markup_fmt" },
      vue = { "markup_fmt" },
      svelte = { "markup_fmt" },
      astro = { "markup_fmt" },
      jinja = { "markup_fmt" },
      jinja2 = { "markup_fmt" },
      j2 = { "markup_fmt" },
      twig = { "markup_fmt" },
      njk = { "markup_fmt" },
      vto = { "markup_fmt" },
      mustache = { "markup_fmt" },
      css = { "malva" },
      scss = { "malva" },
      sass = { "malva" },
      less = { "malva" },
      ron = { "fmtron" },
    },
  })
end

local key_load = true

vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" },
}, {
  load = function(v)
    vim.keymap.set({ "n", "i", "v" }, "<C-S-F>", function()
      if key_load then
        vim.cmd.packadd(v.spec.name)
        load()
        key_load = false
      end
      require("conform").format()
    end, { desc = "Format" })
  end,
})
