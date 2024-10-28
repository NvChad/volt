local api = vim.api
local set_extmark = api.nvim_buf_set_extmark
local state = require "volt.state"

return function(buf, section)
  local v = state[buf]
  local section_lines = section.lines(buf)
  local xpad = section.col_start or v.xpad or 0

  for line_i, val in ipairs(section_lines) do
    local row = line_i + section.row
    local col = xpad

    v.clickables[row] = {}
    v.hoverables[row] = {}

    for _, mark in ipairs(val) do
      local strlen = vim.fn.strwidth(mark[1])
      col = col + strlen

      if mark[3] then
        local virt = { col_start = col - strlen, col_end = col, actions = mark[3] }

        if strlen == 1 and #mark[1] == 1 then
          virt.col_end = virt.col_start
        end

        table.insert(v.clickables[row], virt)

        if type(virt.actions) == "table" then
          virt.ui_type = virt.actions.ui_type
          virt.hover = virt.actions.hover
          table.insert(v.hoverables[row], virt)
        end
      end
    end
  end

  -- remove 3rd item from virt_text table cuz its a function
  for _, line in ipairs(section_lines) do
    for _, marks in ipairs(line) do
      table.remove(marks, 3)
    end
  end

  for line, marks in ipairs(section_lines) do
    local row = line + section.row
    local opts = { virt_text_pos = "overlay", virt_text = marks, id = row }
    set_extmark(buf, v.ns, row - 1, xpad, opts)
  end
end
