-- local termial = "foot -d none"
local terminal = "alacritty"
local browser = "~/app/zen/zen"
-- local wallpapern = "wpaperctl next"
-- local wallpaperp = "wpaperctl previous"
local wallpapern = "lianwall next"
local wallpaperp = "lianwall prev"

local priMod = "SUPER"
local secMod = priMod .. " + SHIFT"
local thiMod = priMod .. " + ALT"
local forMod = priMod .. " + CTRL"

hl.bind(priMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(priMod .. " + E", hl.dsp.exec_cmd(terminal .. " -a yazi -e yazi"))
hl.bind(secMod .. " + V", hl.dsp.exec_cmd(terminal .. " -a clipse -e clipse"))
hl.bind(secMod .. " + R", hl.dsp.exec_cmd(terminal .. " -a rmpc -e rmpc"))
hl.bind("CTRL + SHIFT + ESCAPE", hl.dsp.exec_cmd(terminal .. " -a btop -e btop"))
hl.bind(priMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("veila lock"))

hl.bind(priMod .. " + bracketright", hl.dsp.exec_cmd(wallpapern))
hl.bind(priMod .. " + bracketleft", hl.dsp.exec_cmd(wallpaperp))
hl.bind(secMod .. " + P", hl.dsp.exec_cmd("lianwall switch"))

hl.bind(priMod .. " + C", hl.dsp.exec_cmd("colorpicker -a"))
hl.bind(priMod .. " + N", hl.dsp.exec_cmd("neovide"))
hl.bind(priMod .. " + M", hl.dsp.exec_cmd("mpv --player-operation-mode=pseudo-gui"))

hl.bind(priMod .. " + D", hl.dsp.exec_cmd("eww-window toggle bar"))
-- hl.bind(priMod .. " + Z", hl.dsp.exec_cmd("eww-minimize minimizecurrent"))
-- hl.bind(priMod .. " + X", hl.dsp.exec_cmd("eww-minimize reminimize"))
hl.bind(forMod .. " + equal", hl.dsp.exec_cmd("eww-volume adjustbykey 0.05"))
hl.bind(forMod .. " + minus", hl.dsp.exec_cmd("eww-volume adjustbykey -0.05"))
hl.bind(forMod .. " + BackSpace", hl.dsp.exec_cmd("eww-volume defaultbykey"))
hl.bind(forMod .. " + M", hl.dsp.exec_cmd("eww-volume togglebykey"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("eww-volume togglebykey"))

hl.bind(
  secMod .. " + S",
  hl.dsp.exec_cmd("screentool -n -t capture -s area -f ~/screenshots/area-$(date +'%F-%T-%N.png')")
)
hl.bind("Print", hl.dsp.exec_cmd("screentool -n -t capture -s full -f ~/screenshots/full-$(date +'%F-%T-%N.png')"))

hl.bind(secMod .. " + Q", hl.dsp.exit())

hl.bind(priMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(priMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(priMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(priMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(priMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(priMod .. " + 6", hl.dsp.focus({ workspace = 6 }))

hl.bind(priMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(priMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(priMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(priMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(priMod .. " + LEFT", hl.dsp.focus({ direction = "left" }))
hl.bind(priMod .. " + DOWN", hl.dsp.focus({ direction = "down" }))
hl.bind(priMod .. " + UP", hl.dsp.focus({ direction = "up" }))
hl.bind(priMod .. " + RIGHT", hl.dsp.focus({ direction = "right" }))

hl.bind(priMod .. " + W", hl.dsp.window.kill())
hl.bind(priMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(priMod .. " + R", hl.dsp.window.center())
hl.bind(priMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(secMod .. " + C", hl.dsp.window.cycle_next())
hl.bind(secMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

hl.bind(secMod .. " + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(secMod .. " + J", hl.dsp.window.swap({ direction = "down" }))
hl.bind(secMod .. " + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(secMod .. " + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(secMod .. " + LEFT", hl.dsp.window.swap({ direction = "left" }))
hl.bind(secMod .. " + DOWN", hl.dsp.window.swap({ direction = "down" }))
hl.bind(secMod .. " + UP", hl.dsp.window.swap({ direction = "up" }))
hl.bind(secMod .. " + RIGHT", hl.dsp.window.swap({ direction = "right" }))

hl.bind(thiMod .. " + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(thiMod .. " + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(thiMod .. " + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(thiMod .. " + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(thiMod .. " + LEFT", hl.dsp.window.move({ direction = "left" }))
hl.bind(thiMod .. " + DOWN", hl.dsp.window.move({ direction = "down" }))
hl.bind(thiMod .. " + UP", hl.dsp.window.move({ direction = "up" }))
hl.bind(thiMod .. " + RIGHT", hl.dsp.window.move({ direction = "right" }))

hl.bind(forMod .. " + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
hl.bind(forMod .. " + J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))
hl.bind(forMod .. " + K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))
hl.bind(forMod .. " + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))
hl.bind(forMod .. " + LEFT", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
hl.bind(forMod .. " + DOWN", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))
hl.bind(forMod .. " + UP", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))
hl.bind(forMod .. " + RIGHT", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))

hl.bind(secMod .. " + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(secMod .. " + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(secMod .. " + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(secMod .. " + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(secMod .. " + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(secMod .. " + 6", hl.dsp.window.move({ workspace = 6 }))

hl.bind(priMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(priMod .. " + mouse:273", hl.dsp.window.resize())
