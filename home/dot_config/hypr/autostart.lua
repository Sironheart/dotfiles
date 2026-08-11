-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("1password")
    hl.exec_cmd("waybar")
    -- hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("systemctl --user start dunst")
end)

local configureGtk = function()
    hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "flexoki"')
    hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
    hl.exec_cmd('gsettings set org.gnome.desktop.interface font-name "JetBrainsMono Nerd Font Mono"')
end

hl.on("hyprland.start", configureGtk)
hl.on("config.reloaded", configureGtk)
