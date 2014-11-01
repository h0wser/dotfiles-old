-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Widgets
local vicious = require("vicious")
local revelation = require("revelation")

local honey = require("honey")

beautiful.init("~/.config/awesome/themes/pluto/theme.lua")
revelation.init()

local blingbling = require("blingbling")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

-- naughty.suspend()
-- }}}

local base_cfg = "/home/h0wser/.config/awesome/"
local hostname = io.popen("uname -n"):read()

--- bashets config
-- bashets.set_script_path("~/.config/awesome/")


-- This is used later as the default terminal and editor to run.
terminal = "xterm"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.max,
	honey.layout.thin,
	honey.layout.focus
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
-- Each screen has its own tag table.
tags[s] = awful.tag({ "01", "02", "03", "04", "05", "06", "07", "08", "09" }, s, layouts[2])
end
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- WIDGETS
-- Spacer thingy
-- Put inbetween stuff and stuff and it'll be fine
-- its ok
spacer = wibox.widget.textbox()
spacer:set_text(" ")

-- Player thingy
music_icon = wibox.widget.imagebox()
music_icon:set_image(theme.stop_icon)
music_icon:set_resize(false)

music_widget = wibox.widget.textbox()
vicious.register(music_widget, vicious.widgets.mpd,
	function (widget, args)
		local ret_text = ""
		if args["{state}"] == "Stop" then 
			ret_text = "" 
			music_icon:set_image(theme.stop_icon)
		elseif args["{state}"] == "Pause" then
			ret_text = '<span foreground="#FFA347">' .. args["{Artist}"] .. " - " .. args["{Title}"] .. '</span>'
			music_icon:set_image(theme.pause_icon)
		else 
			ret_text = '<span foreground="#FFA347">' .. args["{Artist}"] .. " - " .. args["{Title}"] .. '</span>'
			music_icon:set_image(theme.play_icon)
		end
		return ret_text	
	end)

--CPU widget
cpu_icon = wibox.widget.imagebox()
cpu_icon:set_resize(false)
cpu_icon:set_image(beautiful.cpu_icon)

cpu_widget = awful.widget.progressbar()
cpu_widget:set_width(85)
cpu_widget:set_ticks(true)
cpu_widget:set_ticks_size(10)
cpu_widget:set_color("#a366a3")
vicious.register(cpu_widget, vicious.widgets.cpu, '$1')

cpu_margin = wibox.layout.margin(cpu_widget, 7, 12)
cpu_margin:set_top(7)
cpu_margin:set_bottom(8)

cpu_widget = wibox.widget.background(cpu_margin)
cpu_widget:set_bgimage(beautiful.cpu_bg)

-- mem widget
mem_icon = wibox.widget.imagebox()
mem_icon:set_resize(false)
mem_icon:set_image(beautiful.mem_icon)

mem_widget = awful.widget.progressbar()
mem_widget:set_width(85)
mem_widget:set_height(5)
mem_widget:set_ticks(true)
mem_widget:set_ticks_size(10)
mem_widget:set_color("#4bcdd2")
vicious.register(mem_widget, vicious.widgets.mem, '$1')

mem_margin = wibox.layout.margin(mem_widget, 7, 12)
mem_margin:set_top(7)
mem_margin:set_bottom(8)

mem_widget = wibox.widget.background(mem_margin)
mem_widget:set_bgimage(beautiful.mem_bg)

-- Volume widget
volume_icon = wibox.widget.imagebox()
volume_icon:set_resize(false)
volume_icon:set_image(theme.volume_icon)

volume_widget = blingbling.volume({
	bar = true, 
	show_text = true,
	label = "$percent %",
	width = 50,
	height = 20, 
	font="Inconsolata", 
	font_size = 12
	})
volume_widget:set_graph_color("#943561")
volume_widget:update_master()
volume_widget:set_master_control()

-- Net widget
local intr
if hostname == "uranus" then 
	intr = "wlp3s0"
else 
	intr = "enp3s0"
end

net_widget = blingbling.net({interface = intr, show_text = true, font="Inconsolata", font_size = 12})
net_widget:set_ippopup()
net_widget:set_graph_color("#00ff00")

-- Battery widget
-- dont know why this doesn't work with other stuff
bat_widget = wibox.widget.textbox()
vicious.register(bat_widget, vicious.widgets.bat, '<span foreground="#ffaaff">BAT: $2% $1</span>', 12, "BAT0")

-- Pacman widget
pkg_widget = wibox.widget.textbox()
vicious.register(pkg_widget, vicious.widgets.pkg, 
	function(widget, args) 
		return '<span foreground="#ffaaff">Pkg updates: ' .. args[1] .. '</span>'
	end, 180, "Arch")

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", align = "center", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
	left_layout:add(spacer)
    left_layout:add(mylayoutbox[s])
	left_layout:add(spacer)
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
	right_layout:add(pkg_widget)
	right_layout:add(mem_icon)
	right_layout:add(mem_widget)
	right_layout:add(cpu_icon)
	right_layout:add(cpu_widget)
	right_layout:add(music_icon)
	right_layout:add(music_widget)
	right_layout:add(spacer)

	if hostname == "uranus" then 
		right_layout:add(bat_widget) 
		right_layout:add(spacer)
	end

	right_layout:add(volume_icon)
	right_layout:add(volume_widget)
	right_layout:add(spacer)
	right_layout:add(net_widget)
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mytextclock)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
	awful.key({ modkey,			  }, "e",	   revelation),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
	
	-- Lock screen
	awful.key({modkey, "Control"}, "l", function() awful.util.spawn("xscreensaver-command -lock") end) 
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
					 size_hints_honor = false} },
	{ rule = { class = "XTerm" },
		properties = {
			opacity = 0.85
		} },
	{ rule = { class = "heimdallr-client" },
		properties = {
			floating = true
		} },
	{ rule = { class = "Plugin-container" },
		properties = {
			floating = true,
			fullscreen = true
		} },
	{ rule = { class = "Chromium" },
		properties = {
			tag = tags[mouse.screen][2]
		} },
	{ rule = { class = "Skype" },
		properties = {
			tag = tags[mouse.screen][3]
		} },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal  end)
-- }}}

