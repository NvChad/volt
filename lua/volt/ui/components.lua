local M = {}

--- @class CheckboxOptions
--- @field active boolean Indicates if the checkbox is active.
--- @field txt string The text to display next to the checkbox.
--- @field hlon? string|nil Highlight for the active state (optional).
--- @field hloff? string|nil Highlight for the inactive state (optional).
--- @field actions table|nil Actions associated with the checkbox (optional).

--- @param o CheckboxOptions The options for the checkbox.
--- @return string[] A table containing the checkbox representation.
M.checkbox = function(o)
  return {
    (o.active and "  " or "  ") .. o.txt,
    o.active and (o.hlon or "String") or (o.hloff or "ExInactive"),
    o.actions,
  }
end

--- @class ProgressOptions
--- @field w number The total width of the progress bar.
--- @field val number The current value of the progress (0 to 100).
--- @field icon? table active/inactive icon styles, ex: { on = "", off = ""}
--- @field hl? table  active/inactive highlights, ex: { on = "", off = ""}

--- @param o ProgressOptions The options for the progress bar.
--- @return table[] A table containing two elements: the active and inactive parts of the progress bar.
M.progressbar = function(o)
  local opts = {
    icon = { on = "-", off = "-" },
    hl = { on = "exred", off = "linenr" },
  }

  o = vim.tbl_deep_extend("force", opts, o)

  local activelen = math.floor(o.w * (o.val / 100))
  local inactivelen = o.w - activelen

  return {
    { string.rep(o.icon.on, activelen), o.hl.on },
    { string.rep(o.icon.off, inactivelen), o.hl.off },
  }
end

M.separator = function(char, w, hl)
  return { { string.rep(char or "─", w), hl or "linenr" } }
end

return M
