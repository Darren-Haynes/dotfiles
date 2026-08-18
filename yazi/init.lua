require("git"):setup {
	-- Order of status signs showing in the linemode
	order = 1500,
}
require("full-border"):setup {
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
}

-- Show user/group of files in status bar
Status:children_add(function()
	local h = cx.active.current.hovered
	if not h or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line {
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		" ",
	}
end, 500, Status.RIGHT)

-- Show username and hostname in header
Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ""
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)

-- Show symlink in status bar
Status:children_add(function(self)
	local h = self._current.hovered
	if h and h.link_to then
		return " -> " .. tostring(h.link_to)
	else
		return ""
	end
end, 3300, Status.LEFT)

-- 1. Safely remove Yazi's stock elements from the left side to prevent duplicates
Status:children_remove(1, Status.LEFT) -- Removes stock Mode (NOR)
Status:children_remove(2, Status.LEFT) -- Removes stock Size

-- 2. Rebuild the Left Status Bar layout order strictly: NOR --> mod time --> file size
Status:children_add(function(self)
	-- Grab Yazi's native editor mode block (e.g., NOR / SEL / INP)
	local mode = self:mode()

	-- Build the Custom Modification Time
	local h = cx.active.current.hovered
	local time_str = ""

	if h and h.cha and h.cha.mtime then
		local time = math.floor(h.cha.mtime)
		if time > 0 then
			if os.date("%Y", time) == os.date("%Y") then
				local d = os.date("*t", time)
				local month = os.date("%b", time)

				local hour = d.hour % 12
				if hour == 0 then hour = 12 end

				local ampm = d.hour >= 12 and "pm" or "am"
				local min = string.format("%02d", d.min)

				time_str = string.format(" %s-%02d/%d:%s%s ", month, d.day, hour, min, ampm)
			else
				time_str = os.date(" %b-%d/ %Y ", time)
			end
		end
	end

	-- 3. Grab Yazi's native file size or create a themed purple caret
	local size_element
	if h then
		local size = h:size()
		if size then
			size_element = ui.Span(ya.readable_size(size))
		else
			-- Set the color to magenta (the standard terminal color for purple themes)
			size_element = ui.Span("»"):fg("magenta")
		end
	else
		size_element = ui.Span("›"):fg("magenta")
	end

	-- 4. Stitch them all together in your exact requested positional order
	return ui.Line {
		mode,                              -- NOR
		ui.Span(time_str):fg("cyan"),      -- Custom Mod Time
		size_element,                      -- File Size OR Purple Caret
	}
	-- -- Grab Yazi's native file size string data
	-- local size_str = ""
	-- if h then
	-- 	local size = h:size()
	-- 	size_str = size and ya.readable_size(size) or "»"
	-- end

	-- -- Stitch them all together in your exact requested positional order
	-- return ui.Line {
	-- 	mode,                              -- NOR
	-- 	ui.Span(time_str):fg("cyan"),      -- Custom Mod Time
	-- 	ui.Span(size_str),                 -- Native File Size
	-- }
end, 1000, Status.LEFT)
