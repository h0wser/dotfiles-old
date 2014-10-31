local math = math
local ipairs = ipairs

local awful = require("awful")
local beautiful = require("beautiful")

beautiful.init("~/.config/awesome/themes/pluto/theme.lua")

module("honey.layout.thin")

local gap = beautiful.honey.gap
-- Layout that organizes windows in a "thin" fashion
-- Centers windows with a maximum width and organizes them in 
-- columns, if there are more windows than columns they
-- will be tiled vertically

name = "honey_thin"

function arrange(p) 
	local area = p.workarea
	local clients = p.clients
	local max_cols = beautiful.honey.thin_nr_columns
	local cols = math.min(#clients, max_cols)
	local max_width = math.min((area.width - gap * cols) / cols, 600)

	local x_offset = gap + (area.width - cols * max_width - gap * (cols+1)) / 2 
	
	local rows = 1
	local y_offset = gap
	local max_height = area.height - gap
	if cols == max_cols then 
		rows = math.ceil(#clients / max_cols)
		max_height = (area.height) / rows - gap
		y_offset = (area.height / rows)
	end

	local max_fullscreen_height = max_height * 2 + gap

	local current_row = 0
	local current_col = 0
	local extra_clients = #clients % cols
	if extra_clients == 0 then extra_clients = rows + 10 end -- So that clients dont be wierd

	for i, c in ipairs(p.clients) do
		
		local g  = {
			x = area.x + x_offset + max_width * current_col + gap * current_col,
			y = area.y + y_offset * current_row + gap / 2,
			width = max_width,
			height = max_height
		}

		if current_row == rows - 2 and current_col > extra_clients - 1 then
			g.height = max_fullscreen_height
		end
		
		c:geometry(g)

		current_col = current_col + 1
		if current_col > max_cols - 1 then
			current_row = current_row + 1
			current_col = 0
		end
	end

end
