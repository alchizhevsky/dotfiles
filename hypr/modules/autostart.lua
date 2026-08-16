local programs = require("modules.programs")

hl.on("hyprland.start", function()
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Catppuccin-Lavender-Dark-MB'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 24")
	hl.exec_cmd("hyprctl setcursor WhiteSur-cursors 24")

	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	hl.exec_cmd("/usr/libexec/xdg-desktop-portal-hyprland")
	hl.exec_cmd("/usr/libexec/xdg-desktop-portal")
	hl.exec_cmd("systemctl --user start graphical-session.target")

	hl.exec_cmd("hypridle")
	hl.exec_cmd("/usr/libexec/hyprpolkitagent")

	hl.exec_cmd("sway-audio-idle-inhibit")

	hl.exec_cmd("/home/alex/.cargo/bin/wayle panel start")

	hl.exec_cmd("elephant")
	hl.exec_cmd("walker --gapplication-service")

	hl.exec_cmd(programs.terminal)
end)
