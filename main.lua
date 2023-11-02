function love.load()
    --variables
    appWidth = 800
    appHeight = 600
    love.window.setMode(appWidth, appHeight, {resizable=false, vsync=false})

    entities = {}

    --load font
    font = love.graphics.newFont("sansation.ttf",25)
    love.graphics.setFont(font)

	-- Sprite that holds all imagery
    -- imagedata = love.image.newImageData('isometric_demo.png')
	-- sprIsom = love.graphics.newImage(imagedata)
    -- textureWidth = imagedata:getWidth()
    -- textureHeight = imagedata:getHeight()

    --create the player
    -- local player = objectplayer:new("player", player, 20,  gameHeight / 2, 16, 16,
    -- 0, 0, 2, 0, 20)
    -- table.insert(entities, player)

    -- remove objects
    --table.remove(entities,i)

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

    --update the entities
    -- for i,v in ipairs(entities) do
    --     v:update(dt)
    -- end
    
    mouseClicked = false
end

function love.draw()
    love.graphics.setBackgroundColor(0,0,0)

    -- draw the objects
    -- for i,v in ipairs(entities) do
    --     v:draw()
    -- end

    -- Draw Debug Info
    --draw UI
    love.graphics.setColor(1,0,0)
end
