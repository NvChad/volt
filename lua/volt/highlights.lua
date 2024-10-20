local api = vim.api
local lighten = require("volt.color").change_hex_lightness
local bg = vim.o.bg

local highlights = {}

if vim.g.base46_cache then
  local colors = dofile(vim.g.base46_cache .. "colors")

  highlights = {
    ExDarkBg = { bg = colors.darker_black },
    ExDarkBorder = { bg = colors.darker_black, fg = colors.darker_black },

    ExBlack2Bg = { bg = colors.black2 },
    ExBlack2border = { bg = colors.black2, fg = colors.black2 },

    ExRed = { fg = colors.red },
    ExBlue = { fg = colors.blue },
    ExGreen = { fg = colors.green },

    ExBlack3Bg = { bg = colors.one_bg2 },
    ExBlack3Border = { bg = colors.one_bg2, fg = colors.one_bg2 },
    ExLightGrey = { fg = lighten(colors.grey, bg == "dark" and 35 or -35) },
  }
else
  local normal_bg = api.nvim_get_hl(0, { name = "Normal" }).bg

  normal_bg = "#" .. ("%06x"):format((normal_bg == nil and 0 or normal_bg))

  local darker_bg = lighten(normal_bg, -3)
  local lighter_bg = lighten(normal_bg, 5)
  local black3_bg = lighten(normal_bg, 10)

  highlights = {
    ExDarkBg = { bg = darker_bg },
    ExDarkBorder = { bg = darker_bg, fg = darker_bg },

    ExBlack2Bg = { bg = lighter_bg },
    ExBlack2Border = { bg = lighter_bg, fg = lighter_bg },

    ExRed = { link = "ErrorMsg" },
    EXBlue = { link = "Function" },
    ExGreen = { link = "String" },

    ExBlack3Bg = { bg = black3_bg },
    ExBlack3Border = { bg = black3_bg, fg = black3_bg },
    ExLightGrey = { fg = lighten(normal_bg, bg == "dark" and 35 or -35) },
  }
end

for name, val in pairs(highlights) do
  vim.api.nvim_set_hl(0, name, val)
end
