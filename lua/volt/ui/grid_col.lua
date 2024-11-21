local add_empty_space = function(lines, w, pad)
  for _, line in ipairs(lines) do
    local len = 0

    for _, cell in ipairs(line) do
      len = len + vim.api.nvim_strwidth(cell[1])
    end

    table.insert(line, { string.rep(" ", w - len+pad) })
  end

  return lines
end

local append_tb = function(t1, t2)
  for _, v in ipairs(t2) do
    table.insert(t1, v)
  end
end

return function(columns)
  local ui_sections = {}

  for _, column in ipairs(columns) do
    table.insert(ui_sections, add_empty_space(column.lines, column.w, column.pad or 0))
  end

  local last_section = #ui_sections

  for i, line in ipairs(ui_sections[1]) do
    for j = 2, last_section do
      append_tb(line, ui_sections[j][i] or {})
    end
  end

  return ui_sections[1]
end
