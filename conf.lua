function love.conf(t)
	t.identity = nil
	t.version = "11.3"
	
	--com.tokyoscale.bubbles

	t.window.title = "Bubbles"
	t.window.icon = "icon.png"

	t.window.srgb = false
	
    t.window.vsync = false

	t.window.fullscreen = true
    t.window.fullscreentype = "desktop"

	t.window.msaa = 4
	
	t.modules.physics = false
    t.modules.joystick = false

end