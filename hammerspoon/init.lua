hs.loadSpoon("SpoonInstall")

local windowManagement = dofile(hs.configdir .. "/window-management.lua")

local windowMods = { "ctrl", "cmd" }
local windowShiftMods = { "ctrl", "shift", "cmd" }

windowManagement.start({
    animationDuration = 0,
    setFrameCorrectness = false,
    hotkeys = {
        left = { windowMods, "j" },
        right = { windowMods, "l" },
        up = { windowMods, "i" },
        down = { windowMods, "," },
        upleft = { windowMods, "u" },
        upright = { windowMods, "o" },
        botleft = { windowMods, "m" },
        botright = { windowMods, "." },
        maximum = { windowMods, "k" },
        toggleFullScreen = { windowShiftMods, "k" },
        toggleZoom = { windowMods, "z" },
        center = { windowMods, "c" },
        nextScreen = { windowMods, "n" },
        previousScreen = { windowMods, "p" },
        resizeOut = { windowShiftMods, "[" },
        resizeIn = { windowShiftMods, "]" },
    },
})

spoon.SpoonInstall.repos.Eikana = {
    url = "https://github.com/kouhin/Eikana.spoon",
    desc = "Eikana spoon repository",
    branch = "main",
}

spoon.SpoonInstall:andUse("Eikana", {
    repo = "Eikana",
    config = {
        userMapping = {
            rightshift = "com.apple.inputmethod.SCIM.WBX",
        },
        override = true
    },
    start = true
})
