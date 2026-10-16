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

for _, mode in ipairs(ALL_MODES) do
  bindings[mode] = {}
end

for _, binding in pairs(keybindings) do
  for _, mode in pairs(binding.modes) do
    assert(bindings[mode], "mode '" .. mode .. "' is missing from ALL_MODES")
    bindings[mode][binding.description] = binding.buttons
  end
end

local output_file = io.open("keybindings.md", "w")
io.output(output_file)

io.write("# Key bindings\n\n")

-- modes in ALL_MODES order, entries sorted alphabetically, so the output is stable
for _, mode in ipairs(ALL_MODES) do
  local mode_bindings = bindings[mode]
  local descriptions = {}
  for descr in pairs(mode_bindings) do table.insert(descriptions, descr) end
  table.sort(descriptions)

  io.write("## " .. mode .. " mode\n\n")
  for _, descr in ipairs(descriptions) do
    local buttons = {}
    for _, key in ipairs(mode_bindings[descr]) do
      table.insert(buttons, "`" .. key .. "`")
    end
    io.write("* " .. descr .. ": " .. table.concat(buttons, ", ") .. "\n")
  end
  io.write("\n")
end

io.close(output_file)
