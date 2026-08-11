-- See https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = {
                colors = { "rgba(3aa99fee)", "rgba(4385beee)" },
                angle = 45,
            },
            inactive_border = "rgba(403e3caa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 4,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.8,
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
            xray = true,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = false,
    },
})

local curves = {
    easeOutQuint = { { 0.23, 1 }, { 0.32, 1 } },
    easeInOutCubic = { { 0.65, 0.05 }, { 0.36, 1 } },
    linear = { { 0, 0 }, { 1, 1 } },
    almostLinear = { { 0.5, 0.5 }, { 0.75, 1 } },
    quick = { { 0.15, 0 }, { 0.1, 1 } },
}

for name, points in pairs(curves) do
    hl.curve(name, { type = "bezier", points = points })
end

local animations = {
    { leaf = "global", speed = 10, bezier = "default" },
    { leaf = "border", speed = 5.39, bezier = "easeOutQuint" },
    { leaf = "windows", speed = 4.79, bezier = "easeOutQuint" },
    { leaf = "windowsIn", speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" },
    { leaf = "windowsOut", speed = 1.49, bezier = "linear", style = "popin 87%" },
    { leaf = "fadeIn", speed = 1.73, bezier = "almostLinear" },
    { leaf = "fadeOut", speed = 1.46, bezier = "almostLinear" },
    { leaf = "fade", speed = 3.03, bezier = "quick" },
    { leaf = "layers", speed = 3.81, bezier = "easeOutQuint" },
    { leaf = "layersIn", speed = 4, bezier = "easeOutQuint", style = "fade" },
    { leaf = "layersOut", speed = 1.5, bezier = "linear", style = "fade" },
    { leaf = "fadeLayersIn", speed = 1.79, bezier = "almostLinear" },
    { leaf = "fadeLayersOut", speed = 1.39, bezier = "almostLinear" },
    { leaf = "workspaces", speed = 1.94, bezier = "almostLinear", style = "fade" },
    { leaf = "workspacesIn", speed = 1.21, bezier = "almostLinear", style = "fade" },
    { leaf = "workspacesOut", speed = 1.94, bezier = "almostLinear", style = "fade" },
    { leaf = "zoomFactor", speed = 7, bezier = "quick" },
}

for _, animation in ipairs(animations) do
    animation.enabled = true
    hl.animation(animation)
end
