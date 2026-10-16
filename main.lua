require "keybindings"
require "modes"

function initUi()
  local index = 1
  for _, binding in pairs(keybindings) do
    for _, button in pairs(binding.buttons) do
      for _, validMode in pairs(binding.modes) do
        -- registerUi takes the *name* of a global function as callback
        _G["f" .. tostring(index)] = function () handle(button) end
        app.registerUi({
          ["menu"]        = binding.description .. " (" .. validMode .. " mode)",
          ["callback"]    = "f" .. tostring(index),
          ["accelerator"] = button
        })
        index = index + 1
      end
    end
  end
end


currentMode = "tool"
lastPage = 1
sticky = false

