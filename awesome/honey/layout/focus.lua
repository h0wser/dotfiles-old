local math = math
local ipairs = ipairs

local awful = require("awful")
local beautiful = require("beautiful")

beautiful.init("~/.config/awesome/theme/theme.lua")

module("honey.layout.focus")

local gap = beautiful.honey.gap

-- Layout that uses on big window in the middle of the screen 
-- Puts other clients to the left and right of the middle window
name = "honey_focus"
function arrange(p)
	local area = p.workarea
	local clients = p.clients 

	local side_width = area.width / 4 - gap
	local side_height = (area.height - gap) / 2 - gap

	local positions = {
		{
			x = area.x + gap,
			y = area.y + gap
		},
		 {
			x = area.x + (side_width + gap) * 3,
			y = area.y + gap
		},
		 {
			x = area.x + gap,
			y = area.y + gap * 2 + side_height
		},
		 {
			x = area.x + (side_width + gap) * 3,
			y = area.y + gap * 2 + side_height
		},
	}
	for i, c in ipairs(p.clients) do
		local g = {}
		if i == 1 then
			g.x = area.x + (area.width / 4) + gap
			g.y = area.y + gap
			g.width = (area.width / 4) * 2 - gap * 2
			g.height = area.height - gap * 2
		elseif i <= 5 then
			g.x = positions[i-1].x
			g.y = positions[i-1].y
			g.width = side_width
			g.height = side_height
		else 
			awful.client.floating.set(c, true)
		end
		c:geometry(g)
	end
end


