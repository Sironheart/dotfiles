-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output = "DP-1",
    mode = "highrr",
    position = "0x0",
    scale = 1,
    bitdepth = 10,
    vrr = 2,
})

hl.monitor({
    output = "HDMI-A-2",
    mode = "preferred",
    position = "auto",
    scale = "auto",
    mirror = "DP-1",
})

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

for workspace = 1, 5 do
    hl.workspace_rule({
        workspace = tostring(workspace),
        monitor = "DP-1",
    })
end

for workspace = 6, 10 do
    hl.workspace_rule({
        workspace = tostring(workspace),
        monitor = "HDMI-A-1",
    })
end

-- Ignore maximize requests from all apps.
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland.
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "1password-float",
    match = { title = "1Password" },
    float = true,
})

hl.window_rule({
    name = "pic-in-pic",
    match = {
        class = "zen",
        title = "Picture-in-Picture",
    },
    float = true,
    size = { 449, 253 },
    pin = true,
    move = { "100%-w-16", "100%-w-16" },
})

hl.window_rule({
    name = "audio",
    match = { class = "org.pulseaudio.pavucontrol" },
    float = true,
    move = { 18, 70 },
    size = { 750, 400 },
})
