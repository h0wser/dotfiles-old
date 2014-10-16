local math = math
local ipair = ipair

honey = {}

honey.testlayout = { name = "test" }

function honey.testlayout.arrange(p)
	local area = p.workarea
	for i, c in ipairs(p.clients) do
		local g = {
			x = (i-1) * 100 + area.x,
			y = (i-1) * 100 + area.y,
			width = 100,
			height = 100,
			screen = p.screen
		}
		c:geometry(g)
	end
end

return honey
