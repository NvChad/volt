local separator = require("volt.ui.components").separator

local get_column_widths = function(tb, w)
  local maxrow = #tb[1]
  local sum = 0
  local result = {}

  for i = 1, maxrow do
    local maxlen = 0
    for _, row in ipairs(tb) do
      maxlen = math.max(maxlen, vim.api.nvim_strwidth(row[i]))
    end
    table.insert(result, maxlen)
    sum = sum + maxlen
  end

  local remaining_space = w - sum
  local ratio = math.floor(remaining_space / maxrow)

  return vim.tbl_map(function(x)
    return x + ratio
  end, result)
end

return function(tbl, w)
  local sep = separator(nil, w)
  local title_sep = separator(nil, w, "exgreen")

  local col_widths = get_column_widths(tbl, w)

  local lines = {}
  table.insert(lines, title_sep)

  for line_i, row in ipairs(tbl) do
    local line = {}

    for i, v in ipairs(row) do
      local maxlen = col_widths[i]
      local strlen = vim.api.nvim_strwidth(tostring(v))
      local pad = string.rep(" ", maxlen - strlen)
      local str = v .. pad
      table.insert(line, { str, line_i == 1 and "exgreen" or "normal" })
    end
    table.insert(lines, line)
    table.insert(lines, line_i == 1 and separator(nil, w, "exgreen") or sep)
  end

  return lines
end
