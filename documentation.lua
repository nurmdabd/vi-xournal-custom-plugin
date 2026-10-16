require "keybindings"
function tableToString(tbl, indent)
    indent = indent or ""
    local result = ""
    for k, v in pairs(tbl) do
      if type(v) == "table" then
        result = result .. indent .. tostring(k) .. ":\n"
        result = result .. tableToString(v, indent .. "  ") -- recursive call with extra indent
      else
        result = result .. indent .. tostring(k) .. ": " .. tostring(v) .. "\n"
      end
    end
    return result
  end









local bindings = {}

for _, mode in pairs(ALL_MODES) do
  bindings[mode] = {}
  -- print(tableToString(bindings))
end


for a, binding in pairs(keybindings) do
  for b, mode in pairs(binding.modes) do
    bindings[mode][binding.description] = binding.buttons
    -- print(tableToString(bindings))
  end
end

local output_file = io.open("keybindings.md", "w")
io.output(output_file)

io.write("# Key bindings\n\n")

for mode, mode_bindings in pairs(bindings) do
  io.write("## " .. mode .. " mode\n\n")
  for descr, keys in pairs(mode_bindings) do
    local buttons = ""
    local first = true
    for _, key in ipairs(keys) do
      if first then
	buttons = "`" .. key .. "`"
	first = false
      else
	buttons = buttons .. ", " .. "`" .. key .. "`"
      end
    end
    io.write("* " .. descr .. ": " .. buttons .. "\n")
  end
  io.write("\n")
end

io.close(output_file)






function tableToString(tbl, indent)
    indent = indent or ""
    local result = ""
    for k, v in pairs(tbl) do
      if type(v) == "table" then
        result = result .. indent .. tostring(k) .. ":\n"
        result = result .. tableToString(v, indent .. "  ") -- recursive call with extra indent
      else
        result = result .. indent .. tostring(k) .. ": " .. tostring(v) .. "\n"
      end
    end
    return result
  end