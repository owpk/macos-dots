local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local popup_width = 250

local home = "/Users/" .. os.getenv("USER") .. "/.config/sketchybar"

local mem_percent = sbar.add("item", "widgets.mem1", {
  position = "right",
  icon = { drawing = false },
  label = {
    string = "??%",
    padding_left = -1,
    font = { family = settings.font.numbers }
  },
  script = home .. "/helpers/scripts/mem.sh",
  update_freq = 50,
})

local mem_icon = sbar.add("item", "widgets.mem2", {
  position = "right",
  padding_right = -1,
  icon = {
    string = icons.mem,
    width = 0,
    align = "left",
    color = colors.grey,
    font = {
      style = settings.font.style_map["Regular"],
      size = 14.0,
    },
  },
  label = {
    width = 25,
    align = "left",
    font = {
      style = settings.font.style_map["Regular"],
      size = 14.0,
    },
  },
})

sbar.add("bracket", "widgets.mem.bracket", { mem_percent.name, mem_icon.name }, {
  background = { color = colors.bg1 }
})
