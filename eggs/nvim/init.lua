vim.loader.enable()
require("options")
require("keymaps")
require("lsp")

require("utils.load_theme")
  -- {# replace_in(`"`, replace_nvim_theme()) #}
  .load("tokyonight-moon")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when copying",
  group = vim.api.nvim_create_augroup("highlight-copy", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

if vim.g.neovide then
  vim.keymap.set({ "n", "x", "v" }, "<C-S-V>", '"+p', { desc = "Paste system clipboard" })
  vim.keymap.set({ "i", "c" }, "<C-S-V>", "<C-R>+", { desc = "Paste system clipboard" })
  vim.g.neovide_refresh_rate = 120
  -- vim.g.neovide_cursor_animation_length = 0.04
  -- vim.g.neovide_cursor_trail_size = 0.7
  vim.g.neovide_cursor_animate_in_insert_mode = false
  -- vim.g.neovide_cursor_vfx_mode = "sonicboom"
  -- vim.g.neovide_floating_blur_amount_x = 0.0
  -- vim.g.neovide_floating_blur_amount_y = 0.0
  vim.g.neovide_floating_shadow = false
  -- vim.g.neovide_floating_z_height = 0
  -- vim.g.neovide_light_angle_degrees = 0
  -- vim.g.neovide_light_radius = 0
  -- vim.g.neovide_floating_corner_radius = 0

  -- 缩放
  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
  end)
  vim.keymap.set("n", "<C-0>", function()
    vim.g.neovide_scale_factor = 1
  end)
  -- neovide 背景颜色
  -- {% if theme.color_name != "wallpaper" %}
  -- {# replace_color(theme.colors.obackground) #}
  vim.api.nvim_set_hl(0, "Normal", { bg = "#222436" })
  -- {% end %}
  -- 清除颜色 防止 浮动窗口有背景模糊
  vim.cmd("hi clear Normal")
end
