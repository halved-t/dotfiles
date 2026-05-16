hl.window_rule({
    name = "suppress-maximize-events",

    match = {
        class = ".*",
    },

    suppress_event = "maximize",
})

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
    name = "move-hyprland-run",

    match = {
        class = "hyprland-run",
    },

    move = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name = "pavucontrol-floater",

    match = {
        class = "org.pulseaudio.pavucontrol",
    },

    float = true,
})

hl.window_rule({
    name = "qemu-floater",

    match = {
        class = "qemu",
    },

    float = true,
})