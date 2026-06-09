hl.window_rule({
  name = "neovide",
  match = { class = "neovide" },
  opacity = 0.69,
  float = true,
  size = { 1831, 1035 },
})
hl.window_rule({
  name = "yazi",
  match = { class = "yazi" },
  float = true,
  size = { 1280, 726 },
})
hl.window_rule({
  name = "rmpc",
  match = { class = "rmpc" },
  float = true,
  size = { 1280, 726 },
})
hl.window_rule({
  name = "btop",
  match = { class = "btop" },
  float = true,
  size = { 1536, 864 },
})
hl.window_rule({
  name = "clipse",
  match = { class = "clipse" },
  float = true,
  size = { 720, 480 },
})
hl.window_rule({
  name = "mpv",
  match = { class = "mpv" },
  float = true,
})

hl.layer_rule({
  name = "bar",
  match = { namespace = "bar" },
  -- blur = true,
  ignore_alpha = 0,
})
hl.layer_rule({
  name = "bar-right-slide",
  match = { namespace = "bar-right-slide" },
  blur = true,
  animation = "slide right",
  ignore_alpha = 0,
})
hl.layer_rule({
  name = "bar-center-popin",
  match = { namespace = "bar-center-popin" },
  blur = true,
  animation = "slide bottom",
  -- animation = "layersIn"
  ignore_alpha = 0,
})

hl.window_rule({
  name = "alacritty",
  match = { class = "alacritty" },
  no_blur = true,
})
hl.window_rule({
  name = "foot",
  match = { class = "foot" },
  no_blur = true,
})

hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})
