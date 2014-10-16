local math = math
local ipair = ipair

honey = {}

honey.layout = {}

-- Layout that organizes windows in a "thin" fashion
-- Centers windows with a maximum width and organizes them in 
-- columns, if there are more windows than columns they
-- will be tiled vertically
honey.layout.thin = { name = "honey_thin" }
function honey.layout.thin.arrange(p) 
	local area = p.workarea
	local clients = p.clients
	local gap = 40
	local max_cols = 3
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

	local current_row = 0
	local current_col = 0

	for i, c in ipairs(p.clients) do
		
		local g  = {
			x = area.x + x_offset + max_width * current_col + gap * current_col,
			y = area.y + y_offset * current_row + gap / 2,
			width = max_width,
			height = max_height
		}
		c:geometry(g)

		current_col = current_col + 1
		if current_col > max_cols - 1 then
			current_row = current_row + 1
			current_col = 0
		end
	end

end
return honey
