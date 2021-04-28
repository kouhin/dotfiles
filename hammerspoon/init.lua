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

hs.logger.new('IM', 'debug'):d(hs.inspect(hs.keycodes.methods()))

local simpleCmd = false
local simpleOpt = false
local map = hs.keycodes.map
local function eikanaEvent(event)
    local c = event:getKeyCode()
    local f = event:getFlags()
    if event:getType() == hs.eventtap.event.types.keyDown then
        if f['cmd'] then
            simpleCmd = true
        end
        if f['alt'] then
           simpleOpt = true
        end
    elseif event:getType() == hs.eventtap.event.types.flagsChanged then
        if not f['cmd'] then
            if simpleCmd == false then
                if c == map['cmd'] then
                    hs.keycodes.setMethod('Romaji')
                elseif c == map['rightcmd'] then
                    hs.keycodes.setMethod('Hiragana')
                end
            end
            simpleCmd = false
        end
        if not f['alt'] then
            if simpleOpt == false then
                if c == map['rightalt'] then
                    hs.keycodes.setMethod('Wubi - Simplified')
                end
            end
            simpleCmd = false
        end
    end
end

eikana = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged}, eikanaEvent)
eikana:start()
