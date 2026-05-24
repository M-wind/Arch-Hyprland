local key_load = true

local load = function()
  require("toggleterm").setup({
    size = 20,
    -- open_mappings = [[<c-\>]],
    hide_numbers = true,
    autochdir = false,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    -- direction = "float",
    direction = "horizontal",
    close_on_exit = true,
    shell = "~/app/tools/nu",
    float_opts = {
      border = "curved",
      winblend = 0,
    },
    highlights = {
      FloatBorder = {
        link = "FloatBorder",
      },
    },
  })
  function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
    -- vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
    -- vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
    -- vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
    -- vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
    -- vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
  end

  vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
end

vim.pack.add({
  { src = "https://github.com/akinsho/toggleterm.nvim" },
}, {
  load = function(v)
    vim.keymap.set("n", "<C-\\>", function()
      if key_load then
        vim.cmd.packadd(v.spec.name)
        load()
        key_load = false
      end
    vim.cmd("ToggleTerm")
    end, { desc = "Open Termianl" })
  end,
})
