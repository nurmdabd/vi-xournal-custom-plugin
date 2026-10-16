require "api"
require "colors"
require "keybindings"

-- a one-shot (non-sticky) mode is left automatically when no key was
-- pressed for more than this many seconds
MODE_TIMEOUT = 5

-- set to true to write every key press to debug_output.log in the plugin folder
DEBUG = false

local pluginDir = debug.getinfo(1, "S").source:sub(2):match("^(.*[/\\])") or ""
local firstLog = true

function log(msg)
  if not DEBUG then return end
  -- overwrite the log on the first message, append afterwards
  local file = io.open(pluginDir .. "debug_output.log", firstLog and "w" or "a")
  firstLog = false
  if file then
    file:write(os.date("%X") .. ": " .. msg .. "\n")
    file:close()
  end
end

local lastKeyTime = os.time()

function handle(key)
  local now = os.time()
  if currentMode ~= "tool" and not sticky and now - lastKeyTime > MODE_TIMEOUT then
    log("No key for more than " .. MODE_TIMEOUT .. " seconds, back to tool mode")
    currentMode = "tool"
  end
  lastKeyTime = now
  log("Key " .. key .. " in " .. currentMode .. " mode")

  for _, binding in pairs(keybindings) do
    if contains(binding.buttons, key) and contains(binding.modes, currentMode) then
      -- automatically return to tool mode from all other modes
      if currentMode ~= "tool" and not sticky then
        currentMode = "tool"
      end
      binding.call()
      print(binding.description)
      return
    end
  end
  -- the key means nothing in this one-shot mode: leave it and
  -- treat the key as a tool mode key instead
  if currentMode ~= "tool" and not sticky then
    currentMode = "tool"
    handle(key)
  end
end

-- checks whether element is in list (slightly hacky)
function contains(list, element)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set[element]
end
