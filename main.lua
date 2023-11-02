function love.load()
    --variables
    appWidth = 640
    appHeight = 480
    love.window.setMode(appWidth, appHeight, {resizable=true, vsync=false})
    love.graphics.setBackgroundColor(1,1,1) --white

    --load font
    font = love.graphics.newFont("sansation.ttf",25)
    love.graphics.setFont(font)

	-- Sprite that holds all imagery
    -- imagedata = love.image.newImageData('isometric_demo.png')
	-- sprIsom = love.graphics.newImage(imagedata)
    -- textureWidth = imagedata:getWidth()
    -- textureHeight = imagedata:getHeight()

    -- mouse
    mouseClicked = false
    vMouse = {x=0, y=0}
end

function love.keypressed(key)
end

function love.keyreleased(key)
end

function love.mousemoved( x, y, dx, dy, istouch )
    vMouse.x = x
    vMouse.y = y
end

function love.mousepressed(x,y,button, istouch)
	if button == 1 then
		mouseClicked = true
	end
end

function love.update(dt)
    
    mouseClicked = false
end

function love.draw()
    love.graphics.setBackgroundColor(1,1,1)

    love.graphics.setColor(0,0,0)
    local width, height = love.graphics.getDimensions( )
    love.graphics.rectangle( "fill", 0, 0, 100, height)
    love.graphics.setColor(1,1,1)

    -- Draw Debug Info
    --draw UI
    love.graphics.setColor(1,0,0)
end
