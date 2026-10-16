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

-- overview table: one row per key, one column per mode
local byKey = {}
for _, binding in pairs(keybindings) do
  for _, key in ipairs(binding.buttons) do
    byKey[key] = byKey[key] or {}
    for _, mode in pairs(binding.modes) do
      byKey[key][mode] = binding.description
    end
  end
end

local keys = {}
for key in pairs(byKey) do table.insert(keys, key) end
-- sort by the key itself, unshifted before shifted (a, <Shift>a, b, ...)
table.sort(keys, function(a, b)
  local baseA, baseB = a:gsub("^<Shift>", ""), b:gsub("^<Shift>", "")
  if baseA ~= baseB then return baseA < baseB end
  return #a < #b
end)

io.write("## All keys by mode\n\n")
io.write("| Key | " .. table.concat(ALL_MODES, " | ") .. " |\n")
io.write("|---" .. string.rep("|---", #ALL_MODES) .. "|\n")
for _, key in ipairs(keys) do
  local cells = {}
  for _, mode in ipairs(ALL_MODES) do
    table.insert(cells, byKey[key][mode] or "")
  end
  io.write("| `" .. key .. "` | " .. table.concat(cells, " | ") .. " |\n")
end

io.close(output_file)
