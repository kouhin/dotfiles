hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall.repos.ShiftIt = {
   url = "https://github.com/peterklijn/hammerspoon-shiftit",
   desc = "ShiftIt spoon repository",
   branch = "master",
}

spoon.SpoonInstall:andUse("ShiftIt", { repo = "ShiftIt" })

spoon.ShiftIt:bindHotkeys({
      left = {{ 'ctrl', 'cmd' }, 'j' },
      right = {{ 'ctrl', 'cmd' }, 'l' },
      up = {{ 'ctrl', 'cmd' }, 'i' },
      down = {{ 'ctrl', 'cmd' }, ',' },
      upleft = {{ 'ctrl', 'cmd' }, 'u' },
      upright = {{ 'ctrl', 'cmd' }, 'o' },
      botleft = {{ 'ctrl', 'cmd' }, 'm' },
      botright = {{ 'ctrl', 'cmd' }, '.' },
      maximum = {{ 'ctrl', 'cmd' }, 'k' },
      toggleFullScreen = {{ 'ctrl', 'shift', 'cmd' }, 'k' },
      toggleZoom = {{ 'ctrl', 'cmd' }, 'z' },
      center = {{ 'ctrl', 'cmd' }, 'c' },
      nextScreen = {{ 'ctrl', 'cmd' }, 'n' },
      previousScreen = {{ 'ctrl', 'cmd' }, 'p' },
      resizeOut = {{ 'ctrl', 'cmd' }, '=' },
      resizeIn = {{ 'ctrl', 'cmd' }, '-' }
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
      rightalt = "Wubi - Simplified"
    }
  },
  start = true
})
