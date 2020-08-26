function love.conf(t)
	t.identity = nil
	t.version = "11.3"
	
	--t.window.icon = "graphics/icon.png"

	t.window.title = "The Game"

	t.window.srgb = false
	
    t.window.vsync = false

	--t.window.fullscreen = true
    t.window.fullscreentype = "desktop"
	
	t.modules.physics = false
    t.modules.joystick = false

end