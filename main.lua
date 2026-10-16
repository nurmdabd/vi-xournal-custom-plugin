require "keybindings"
require "modes"

log("Plugin started")

function initUi()
  -- collect what every key does in each mode, so that each key gets
  -- a single menu entry, e.g. "e: Ellipse [shape], Eraser [tool], ..."
  local meanings = {}
  for _, binding in pairs(keybindings) do
    for _, button in pairs(binding.buttons) do
      meanings[button] = meanings[button] or {}
      for _, validMode in pairs(binding.modes) do
        table.insert(meanings[button], binding.description .. " [" .. validMode .. "]")
      end
    end
  end

  local buttons = {}
  for button in pairs(meanings) do table.insert(buttons, button) end
  table.sort(buttons)

  for index, button in ipairs(buttons) do
    table.sort(meanings[button])
    -- registerUi takes the *name* of a global function as callback
    _G["f" .. tostring(index)] = function () handle(button) end
    app.registerUi({
      ["menu"]        = button .. ": " .. table.concat(meanings[button], ", "),
      ["callback"]    = "f" .. tostring(index),
      ["accelerator"] = button
    })
  end
end


currentMode = "tool"
lastPage = 1
sticky = false

