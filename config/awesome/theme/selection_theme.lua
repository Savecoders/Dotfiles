-- requirements
-- ~~~~~~~~~~~~
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local rubato = require("modules.rubato")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local gfs = require('gears.filesystem')


local change_dark_theme = function()
	awful.spawn.with_shell(gears.filesystem.get_configuration_dir() .. "scripts/themes/dark")
	awesome.restart()
end

local change_light_theme = function()
	awful.spawn.with_shell(gears.filesystem.get_configuration_dir() .. "scripts/themes/light")
	awesome.restart()
end

local change_gruvbox_theme = function()
	awful.spawn.with_shell(gears.filesystem.get_configuration_dir() .. "scripts/themes/gruvbox")
	awesome.restart()
end


-- search image for rice

local dark_img = gfs.get_configuration_dir() .. "theme/dark/rice_dark.png"
local light_img = gfs.get_configuration_dir() .. "theme/light/rice_light.png"
local gruvbox_img = gfs.get_configuration_dir() .. "theme/gruvbox/rice_gruvbox.png"


-- create img container

local create_img = require("widgets.button").create_image_onclick

-- containers

local dark = create_img(dark_img, dark_img, change_dark_theme)
local light = create_img(light_img, light_img, change_light_theme)
local gruvbox = create_img(gruvbox_img, gruvbox_img, change_gruvbox_theme)

-- size

dark.forced_height = dpi(160)
light.forced_height = dpi(160)
gruvbox.forced_height = dpi(160)

dark.forced_width = dpi(220)
light.forced_width = dpi(220)
gruvbox.forced_width = dpi(220)

local theme_screen = wibox({
	height  = dpi(180),
	width   = dpi(740),
	shape   = helpers.rrect(beautiful.border_radius),
	bg      = beautiful.bg,
	visible = false,
	ontop   = true,
})

awful.placement.centered(theme_screen, {
	margins = {
		center = beautiful.useless_gap
	}
})

theme_screen:setup {

	{

		{
			dark,
			spacing = dpi(20),
			layout = wibox.layout.fixed.horizontal,
		},

		{
			gruvbox,
			spacing = dpi(20),
			layout = wibox.layout.fixed.horizontal,
		},

		{
			light,
			spacing = dpi(20),
			layout = wibox.layout.fixed.horizontal,
		},

		spacing = dpi(20),
		layout = wibox.layout.fixed.horizontal,
	},

	widget = wibox.container.margin,
	margins = dpi(28)
}

theme_toogle = function()
	if theme_screen.visible == false then
		theme_screen.visible = not theme_screen.visible
	else
		theme_screen.visible = false
	end
end
