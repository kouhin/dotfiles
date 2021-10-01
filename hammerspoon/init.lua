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

table.size = function(t)
   local count = 0
   for _, __ in pairs(t) do
      count = count + 1
   end
   return count
end

local defaultMapping<const> = {
   ['cmd']='Romaji',
   ['rightcmd']='Hiragana'
}
function newEikana(userMapping)
   local map<const> = hs.keycodes.map
   local mapping<const> = {}
   if (userMapping) then
      for k,v in pairs(userMapping) do mapping[map[k]] = v end
   else
      for k,v in pairs(defaultMapping) do mapping[map[k]] = v end
   end

   local prevCode = ''
   local prevFlagSize = 0

   local function eventhandler(event)
      local code<const> = event:getKeyCode()
      local flag<const> = event:getFlags()
      if event:getType() == hs.eventtap.event.types.keyDown then
         prevCode = ''
      elseif event:getType() == hs.eventtap.event.types.flagsChanged then
         local flagSize<const> = table.size(flag)
         if flagSize == 0 then
            if prevFlagSize == 1 and code == prevCode then
               -- FlagSize 1 -> 0
               if mapping[code] ~= nil then
                  if mapping[code] == 'Romaji' then
                     hs.eventtap.keyStroke({}, 102)
                  elseif mapping[code] == 'Hiragana' then
                     hs.eventtap.keyStroke({}, 104)
                  else
                     hs.keycodes.setMethod(mapping[code])
                  end
               end
            else
               prevCode = ''
            end
         elseif flagSize == 1 then
            if prevFlagSize == 0 then
               -- FlagSize 0 -> 1
               prevCode = code
            else
               prevCode = ''
            end
         else
            prevCode = ''
         end
         prevFlagSize = flagSize
      end
   end
   return hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged}, eventhandler)
end

local mapping<const> = {
   ['cmd']='Romaji',
   ['rightcmd']='Hiragana',
   ['rightalt']='Wubi - Simplified'
}

eikana = newEikana(mapping)
eikana:start()
