local obj = {}

local function focusedWindow()
    return hs.window.focusedWindow()
end

local function withFocusedWindow(fn)
    local win = focusedWindow()
    if win then
        fn(win)
    end
end

local firefoxAXAttributes = { "AXEnhancedUserInterface", "AXManualAccessibility" }
local firefoxAXOriginal = {}
local firefoxAXRestoreTimers = {}
local firefoxFrameTimers = {}

local function isFirefoxWindow(win)
    local app = win and win:application()
    local bundleID = app and app:bundleID()
    return bundleID and (
        bundleID == "org.mozilla.firefox"
        or bundleID == "org.mozilla.nightly"
        or bundleID:match("^org%.mozilla%.firefox")
    )
end

local function getAXAttribute(ax, name)
    local ok, value = pcall(function()
        return ax:attributeValue(name)
    end)
    if ok then
        return true, value
    end

    return pcall(function()
        return ax[name]
    end)
end

local function setAXAttribute(ax, name, value)
    local ok, result = pcall(function()
        return ax:setAttributeValue(name, value)
    end)
    if not ok or result == false then
        pcall(function()
            ax[name] = value
        end)
    end
end

local function withFirefoxAXWorkaround(win, fn)
    if not isFirefoxWindow(win) then
        return fn()
    end

    local app = win:application()
    local pid = app and app:pid()
    local ok, ax = pcall(function()
        return app and hs.axuielement.applicationElement(app)
    end)
    if not ok then
        ax = nil
    end
    if not pid or not ax then
        return fn()
    end

    if firefoxAXRestoreTimers[pid] then
        firefoxAXRestoreTimers[pid]:stop()
        firefoxAXRestoreTimers[pid] = nil
    end

    if not firefoxAXOriginal[pid] then
        firefoxAXOriginal[pid] = {}
        for _, name in ipairs(firefoxAXAttributes) do
            local ok, value = getAXAttribute(ax, name)
            if ok then
                firefoxAXOriginal[pid][name] = value
            end
        end
    end

    for _, name in ipairs(firefoxAXAttributes) do
        setAXAttribute(ax, name, false)
    end

    local ok, result = pcall(fn)
    firefoxAXRestoreTimers[pid] = hs.timer.doAfter(0.5, function()
        local original = firefoxAXOriginal[pid]
        if original then
            for name, value in pairs(original) do
                setAXAttribute(ax, name, value)
            end
        end
        firefoxAXOriginal[pid] = nil
        firefoxAXRestoreTimers[pid] = nil
    end)

    if not ok then
        error(result, 0)
    end
    return result
end

local function setWindowFrame(win, frame)
    frame = hs.geometry(frame):floor()

    if not isFirefoxWindow(win) then
        win:setFrame(frame, 0)
        return
    end

    -- Firefox can ignore the move part of a resize+move operation on macOS 26.
    withFirefoxAXWorkaround(win, function()
        win:setSize({ w = frame.w, h = frame.h })
        win:setTopLeft({ x = frame.x, y = frame.y })
    end)

    local id = win:id()
    if id and firefoxFrameTimers[id] then
        firefoxFrameTimers[id]:stop()
    end

    local timer = hs.timer.doAfter(0.08, function()
        if win and win:id() then
            withFirefoxAXWorkaround(win, function()
                win:setTopLeft({ x = frame.x, y = frame.y })
                win:setSize({ w = frame.w, h = frame.h })
                win:setTopLeft({ x = frame.x, y = frame.y })
            end)
        end
        if id then
            firefoxFrameTimers[id] = nil
        end
    end)

    if id then
        firefoxFrameTimers[id] = timer
    end
end

local function moveToScreen(screenFn)
    withFocusedWindow(function(win)
        local screen = win:screen()
        if screen then
            local targetScreen = screenFn(screen)
            if targetScreen then
                local frame = targetScreen:fromUnitRect(screen:toUnitRect(win:frame())):fit(targetScreen:frame())
                setWindowFrame(win, frame)
            end
        end
    end)
end

local function moveToUnit(unit)
    withFocusedWindow(function(win)
        setWindowFrame(win, win:screen():fromUnitRect(unit))
    end)
end

local function resizeWindow(increment)
    withFocusedWindow(function(win)
        local screen = win:screen():frame()
        local frame = win:frame()
        local wStep = math.floor(screen.w / 12)
        local hStep = math.floor(screen.h / 12)
        local x, y, w, h = frame.x, frame.y, frame.w, frame.h

        if increment then
            local newX = math.max(screen.x, x - wStep)
            local newY = math.max(screen.y, y - hStep)
            w = math.min(screen.w - newX + screen.x, w + (x - newX) + wStep)
            h = math.min(screen.h - newY + screen.y, h + (y - newY) + hStep)
            x = newX
            y = newY
        else
            local minWidth = wStep * 3
            local minHeight = hStep * 3
            if w > minWidth then
                x = x + wStep
                w = w - wStep * 2
            end
            if h > minHeight then
                y = y + hStep
                h = h - hStep * 2
            end
        end

        setWindowFrame(win, { x = x, y = y, w = w, h = h })
    end)
end

local actions = {
    left = function() moveToUnit({ 0, 0, 0.5, 1 }) end,
    right = function() moveToUnit({ 0.5, 0, 0.5, 1 }) end,
    up = function() moveToUnit({ 0, 0, 1, 0.5 }) end,
    down = function() moveToUnit({ 0, 0.5, 1, 0.5 }) end,
    upleft = function() moveToUnit({ 0, 0, 0.5, 0.5 }) end,
    upright = function() moveToUnit({ 0.5, 0, 0.5, 0.5 }) end,
    botleft = function() moveToUnit({ 0, 0.5, 0.5, 0.5 }) end,
    botright = function() moveToUnit({ 0.5, 0.5, 0.5, 0.5 }) end,
    maximum = function() moveToUnit({ 0, 0, 1, 1 }) end,
    center = function()
        withFocusedWindow(function(win)
            local screen = win:screen():frame()
            local frame = win:frame()
            frame.x = screen.x + (screen.w - frame.w) / 2
            frame.y = screen.y + (screen.h - frame.h) / 2
            setWindowFrame(win, frame)
        end)
    end,
    resizeOut = function() resizeWindow(true) end,
    resizeIn = function() resizeWindow(false) end,
    toggleFullScreen = function()
        withFocusedWindow(function(win)
            win:toggleFullScreen()
        end)
    end,
    toggleZoom = function()
        withFocusedWindow(function(win)
            win:toggleZoom()
        end)
    end,
    nextScreen = function()
        moveToScreen(function(screen)
            return screen:next()
        end)
    end,
    previousScreen = function()
        moveToScreen(function(screen)
            return screen:previous()
        end)
    end,
}

function obj.start(config)
    config = config or {}
    hs.window.animationDuration = config.animationDuration or 0
    hs.window.setFrameCorrectness = config.setFrameCorrectness or false

    for actionName, hotkey in pairs(config.hotkeys or {}) do
        local action = actions[actionName]
        if action and hotkey then
            hs.hotkey.bind(hotkey[1], hotkey[2], action)
        end
    end
end

return obj
