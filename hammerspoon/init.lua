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

function addSingleModKeyPressEventListener(keys, handler)
   local targetKeyCodes = {}
   for _,v in pairs(keys) do targetKeyCodes[v]=true end

   local prevCode = 0
   local prevFlagSize = 0

   local function reset()
      if prevCode ~= 0 then prevCode = 0 end
   end

   local function eventhandler(event)
      local code = event:getKeyCode()
      local flag = event:getFlags()

      if event:getType() == hs.eventtap.event.types.keyDown then
         return reset()
      end

      if event:getType() == hs.eventtap.event.types.flagsChanged then
         local flagSize = table.size(flag)
         if flagSize == 0  then
            if prevFlagSize == 1 and code == prevCode then
               -- FlagSize 1 -> 0
               if not targetKeyCodes[hs.keycodes.map[code]] then
                  reset()
               else
                  handler(hs.eventtap.event.newKeyEvent(code, false))
               end
            else
               reset()
            end
         elseif flagSize == 1 then
            if prevFlagSize == 0 then
               -- FlagSize 0 -> 1
               prevCode = code
            else
               reset()
            end
         else
            reset()
         end
         prevFlagSize = flagSize
      end
   end
   return hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged}, eventhandler)
end

Eikana = {}

Eikana.mapping = {
   cmd = 'Romaji',
   rightcmd = 'Hiragana'
}

function Eikana:new(mapping)
   self.__index = self
   local obj = {}
   return setmetatable(obj, self)
end

function Eikana:handleEvent(ev)
   local key = hs.keycodes.map[ev:getKeyCode()]
   local method = self.mapping[key]

   if method == nil then return end

   if method == 'Romaji' then
      hs.eventtap.keyStroke({}, 102)
   elseif method == 'Hiragana' then
      hs.eventtap.keyStroke({}, 104)
   else
      hs.keycodes.setMethod(method)
   end
end

function Eikana:start()
   if self.eventtap == nil then return end
   self.eventtap:start()
end

function Eikana:stop()
   if self.eventtap == nil then return end
   self.eventtap:stop()
end

function Eikana:bindKeys(mapping)
   for k, v in pairs(mapping) do self.mapping[k] = v end

   local keys = {}
   for k in pairs(self.mapping) do table.insert(keys, k) end

   local function handleEvent(ev)
      local key = hs.keycodes.map[ev:getKeyCode()]
      local method = self.mapping[key]

      if method == nil then return end

      if method == 'Romaji' then
         hs.eventtap.keyStroke({}, 102)
      elseif method == 'Hiragana' then
         hs.eventtap.keyStroke({}, 104)
      else
         hs.keycodes.setMethod(method)
      end
   end

   self.eventtap = addSingleModKeyPressEventListener(keys, handleEvent)
   self:start()
end

eikana = Eikana:new()
eikana:bindKeys({
      rightalt = 'Wubi - Simplified'
})
