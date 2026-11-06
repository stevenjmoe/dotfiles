---@module 'hl'

--## MONITORS ###

local mainMonitor = "DP-2"

local secondMonitor = "HDMI-A-3"

hl.monitor({
    output   = mainMonitor,
    mode     = "highres@highrr",
    position = "auto-right",
    scale    = 1,
})

hl.monitor({
    output   = secondMonitor,
    mode     = "preferred",
    position = "auto-left",
    scale    = 1,
})

--hl.monitor({
--    output   = secondMonitor,
--    mode     = "disable",
--    position = "auto",
--    scale    = 1,
--})

--monitor = $mainMonitor, disable

hl.workspace_rule({
    workspace = 1,
    monitor = "DP-2",
    default = true,
})

hl.workspace_rule({
    workspace = 2,
    monitor = "DP-2",
})

hl.workspace_rule({
    workspace = 3,
    monitor = "DP-2",
    --rounding = false,
    --border = false,
})

-- gaming

hl.workspace_rule({
    workspace = 4,
    monitor = "DP-2",
})

hl.workspace_rule({
    workspace = 5,
    monitor = "DP-2",
})

hl.workspace_rule({
    workspace = 6,
    monitor = "HDMI-A-3",
    default = true,
})

hl.workspace_rule({
    workspace = 7,
    monitor = "HDMI-A-3",
})

hl.workspace_rule({
    workspace = 8,
    monitor = "HDMI-A-3",
})

hl.workspace_rule({
    workspace = 9,
    monitor = "HDMI-A-3",
})

hl.workspace_rule({
    workspace = 10,
    monitor = "HDMI-A-3",
})

--## MY PROGRAMS ###

local terminal = "ghostty"

local fileManager = "dolphin"

local menu = "wofi --show drun --insensitive"

local notif = "dunst"

local notes = "obsidian"

local music = "ghostty -e rmpc"

local browser = "flatpak run app.zen_browser.zen"

--## AUTOSTART ###


-- focus back on workspace 1 rather than workspace 6 on monitor 2

hl.env("SSH_AUTH_SOCK", os.getenv("XDG_RUNTIME_DIR") .. "/keyring/ssh")


--## ENVIRONMENT VARIABLES ###

hl.env("XCURSOR_SIZE", 24)

hl.env("HYPRCURSOR_SIZE", 24)

--## LOOK AND FEEL ###

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 3,
        border_size = 2,
        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,
        -- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false,
        layout = "dwindle",
        col = {
            active_border = "rgba(0087ff94)",
            inactive_border = "rgba(595959aa)",
        },
    },
})

-- https://wiki.hyprland.org/Configuring/Variables/#decoration

hl.config({
    decoration = {
        rounding = 10,
        active_opacity = 0.85,
        inactive_opacity = 0.75,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
})

hl.config({
    animations = {
        enabled = true,
    },
})
hl.curve("easeOutQuint", {
    type = "bezier",
    points = { { 0.23, 1 }, { 0.32, 1 } },
})
hl.curve("easeInOutCubic", {
    type = "bezier",
    points = { { 0.65, 0.05 }, { 0.36, 1 } },
})
hl.curve("linear", {
    type = "bezier",
    points = { { 0, 0 }, { 1, 1 } },
})
hl.curve("almostLinear", {
    type = "bezier",
    points = { { 0.5, 0.5 }, { 0.75, 1.0 } },
})
hl.curve("quick", {
    type = "bezier",
    points = { { 0.15, 0 }, { 0.1, 1 } },
})
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
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

hl.config({
    dwindle = {
        --pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true,
        -- You probably want this
    },
})

hl.config({
    master = {
        new_status = "slave",
        orientation = "left",
    },
})

-- https://wiki.hyprland.org/Configuring/Variables/#misc

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})

--############

--## INPUT ###

--############

hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 0,
        sensitivity = 0,
        -- -1.0 - 1.0, 0 means no modification.
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.config({
    gestures = {
        --workspace_swipe = false
    },
})

hl.gesture({
    ["fingers"] = 3,
    ["direction"] = "horizontal",
    ["action"] = "workspace",
})

--##################

--## KEYBINDINGS ###

--##################

local mainMod = "ALT"

local reload_waybar = "pkill waybar; waybar &"

hl.bind(mainMod .. " + " .. "Return", hl.dsp.exec_cmd("ghostty"))

hl.bind(mainMod .. " + " .. "Q", hl.dsp.window.close())

hl.bind(mainMod .. " + " .. "M", hl.dsp.exit())

hl.bind(mainMod .. " + " .. "E", hl.dsp.exec_cmd("dolphin"))

hl.bind(mainMod .. " + " .. "V", hl.dsp.window.float())

hl.bind(mainMod .. " + " .. "R", hl.dsp.exec_cmd("wofi --show drun --insensitive"))

hl.bind(mainMod .. " + " .. "P", hl.dsp.window.pseudo())

-- dwindle

hl.bind(mainMod .. " + " .. "D", hl.dsp.layout("togglesplit"))

-- dwindle

hl.bind(mainMod .. " + " .. "W", hl.dsp.exec_cmd("pkill waybar; waybar &"))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "H", hl.dsp.window.move({ direction = "left" }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "L", hl.dsp.window.move({ direction = "right" }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "J", hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "K", hl.dsp.window.move({ direction = "up" }))

-- Move focus with mainMod + arrow keys

hl.bind(mainMod .. " + " .. "h", hl.dsp.focus({ direction = "left" }))

hl.bind(mainMod .. " + " .. "l", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + " .. "j", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + " .. "k", hl.dsp.focus({ direction = "up" }))

-- Switch workspaces with mainMod + [0-9]

hl.bind(mainMod .. " + " .. 1, hl.dsp.focus({ workspace = 1 }))

hl.bind(mainMod .. " + " .. 2, hl.dsp.focus({ workspace = 2 }))

hl.bind(mainMod .. " + " .. 3, hl.dsp.focus({ workspace = 3 }))

hl.bind(mainMod .. " + " .. 4, hl.dsp.focus({ workspace = 4 }))

hl.bind(mainMod .. " + " .. 5, hl.dsp.focus({ workspace = 5 }))

hl.bind(mainMod .. " + " .. 6, hl.dsp.focus({ workspace = 6 }))

hl.bind(mainMod .. " + " .. 7, hl.dsp.focus({ workspace = 7 }))

hl.bind(mainMod .. " + " .. 8, hl.dsp.focus({ workspace = 8 }))

hl.bind(mainMod .. " + " .. 9, hl.dsp.focus({ workspace = 9 }))

hl.bind(mainMod .. " + " .. 0, hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 1, hl.dsp.window.move({ workspace = 1 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 2, hl.dsp.window.move({ workspace = 2 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 3, hl.dsp.window.move({ workspace = 3 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 4, hl.dsp.window.move({ workspace = 4 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 5, hl.dsp.window.move({ workspace = 5 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 6, hl.dsp.window.move({ workspace = 6 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 7, hl.dsp.window.move({ workspace = 7 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 8, hl.dsp.window.move({ workspace = 8 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 9, hl.dsp.window.move({ workspace = 9 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 0, hl.dsp.window.move({ workspace = 10 }))

hl.bind(mainMod .. " + " .. "F", hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + " .. "S", hl.dsp.workspace.toggle_special("magic"))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll

--bind = $mainMod, mouse_down, workspace, e+1

--bind = $mainMod, mouse_up, workspace, e-1

-- Move/resize windows with mainMod + LMB/RMB and dragging

hl.bind(mainMod .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.bind(mainMod .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"), { repeating = true, locked = true })

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"), { repeating = true, locked = true })

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { repeating = true, locked = true })

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { repeating = true, locked = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { repeating = true, locked = true })

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { repeating = true, locked = true })

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "SPACE", hl.dsp.exec_cmd("mpc toggle"))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "N", hl.dsp.exec_cmd("mpc next"))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "P", hl.dsp.exec_cmd("mpc prev"))

--#############################

--## WINDOWS AND WORKSPACES ###

--#############################

-- Ignore maximize requests from apps. You'll probably like this.

hl.window_rule({
    name  = "suppress_event_maxim_250",
    match = {
        --class.* = true,
    },
    -- TODO: review rule: "suppress_event maximize"
})

-- Fix some dragging issues with XWayland

hl.window_rule({
    name  = "no_focus_on_253",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    -- TODO: review rule: "no_focus on"
})

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("dunst")
    hl.exec_cmd("waybar &")
    hl.exec_cmd("[workspace 2 silent] obsidian")
    hl.exec_cmd("[workspace 1 silent] flatpak run app.zen_browser.zen")
    hl.exec_cmd("[workspace 1 silent] sleep 1; ghostty")
    hl.exec_cmd("[workspace 6 silent] sleep 2; ghostty -e rmpc")
    hl.exec_cmd("swaybg -i ~/Pictures/Wallpapers/pixel-art-3440x1440-v0-ko8utbyntngc1.webp")
    hl.exec_cmd("sleep 2; hyprctl dispatch workspace 1")
    hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh")
end)
