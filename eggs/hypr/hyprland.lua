local g_var = require("variables")
require("autostart")
require("keymaps")
require("rules")

hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = "auto",
})

hl.env("HYPRCURSOR_THEME", "phinger-cursors-light")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
  general = {
    gaps_in = 3,
    gaps_out = { top = 6, right = 6, left = 6, bottom = 0 },
    border_size = 0,
    col = {
      active_border = "rgba(98c379ff)",
      inactive_border = "rgba(2222227f)",
    },
    resize_on_border = false,
    allow_tearing = false,
    hover_icon_on_border = true,
    extend_border_grab_area = 20,
    layout = g_var.layout,
  },
  decoration = {
    rounding = 8,
    rounding_power = 2,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    blur = {
      enabled = true,
      size = 6,
      passes = 3,
      ignore_opacity = true,
      new_optimizations = true,
      xray = true,
      input_methods = true,
      input_methods_ignorealpha = 0.79,
      vibrancy = 0.1696,
    },
    shadow = {
      enabled = true,
      range = 18,
      render_power = 4,
      color_inactive = 0x00a29298,
      --  {# replace_color_hypr(theme.colors.cyan) #}
      color = 0xff94e2d5,
    },
  },

  animations = {
    enabled = true,
    workspace_wraparound = true,
  },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "",
    kb_rules = "",
    follow_mouse = 1,
    sensitivity = -0.6,
    accel_profile = "adaptive",
    touchpad = {
      natural_scroll = false,
    },
    numlock_by_default = true,
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

hl.config({
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    disable_splash_rendering = false,
    disable_hyprland_guiutils_check = true,
    disable_xdg_env_checks = true,
    disable_watchdog_warning = true,
    enable_anr_dialog = false,
  },
})

hl.config({
  xwayland = { enabled = false },
})

hl.config({
  render = { direct_scanout = 0 },
})

hl.config({
  ecosystem = { no_update_news = true, no_donation_nag = true },
})

hl.config({
  quirks = { prefer_hdr = 0 },
})

hl.config({ device = {} })

hl.config({
  debug = {
    disable_scale_checks = true,
    colored_stdout_logs = false,
  },
})

hl.config({
  dwindle = {
    preserve_split = true, -- You probably want this
  },
})

hl.config({
  master = {
    new_status = "master",
  },
})

hl.config({
  scrolling = {
    fullscreen_on_one_column = false,
  },
})
