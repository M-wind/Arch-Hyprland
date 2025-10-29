return {
  {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    -- event = "VeryLazy",
    keys = {
      {
        "<C-S-F>",
        function()
          require("conform").format()
        end,
        mode = { "n", "i", "v" },
        desc = "Format",
      },
    },
    config = function()
      local path = function(exe, configname)
        local re = vim.fn.exepath(exe)
        re = vim.fn.fnamemodify(re, ":h")
        return ("%s/%s"):format(re, configname)
      end
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
          taplo = {
            append_args = { "-c", path("taplo", "taplo.toml") },
          },
          yamlfmt = {
            prepend_args = { "-conf", path("yamlfmt", "yamlfmt.yaml") },
          },
          markup_fmt = {
            inherit = false,
            command = "markup_fmt",
            args = { "-f", "$FILENAME", "-c", path("markup_fmt", "markup_fmt.json") },
          },
          malva = {
            inherit = false,
            command = "malva",
            args = { "-f", "$FILENAME", "-c", path("malva", "malva.json") },
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
        },
      })
    end,
  },
}
