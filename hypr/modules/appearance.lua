hl.config({
	cursor = {
		no_hardware_cursors = true,
	},
	general = {
		gaps_in = 0,
		gaps_out = 0,
		border_size = 2,
		col = {
			active_border = "rgb(30,30,46)",
			inactive_border = "rgb(24,24,37)",
		},
		resize_on_border = true,
		allow_tearing = true,
		layout = "dwindle",
	},
	decoration = {
		rounding = 4,
		rounding_power = 15,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 20,
			render_power = 3,
			color = "rgba(11111144)",
		},
		blur = {
			enabled = false,
			special = true,
			popups = true,
			size = 5,
			passes = 3,
			new_optimizations = true,
		},
	},
	animations = {
		enabled = true,
	},
	dwindle = {
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
	misc = {
		force_default_wallpaper = 1,
		disable_hyprland_logo = true,
	},
	input = {
		kb_layout = "us, ru",
		kb_variant = "mac, mac",
		kb_options = "caps:swapescape, grp:alt_space_toggle",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
			tap_to_click = false,
			clickfinger_behavior = true,
		},
	},
	xwayland = {
		force_zero_scaling = true,
	},
})
