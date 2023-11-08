require("listbox")
    
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

    listBox1 = listbox:new("To do", 20, 20, 220, 560)
    table.insert(entities, listBox1)
    listBox2 = listbox:new("Doing", 260, 20, 220, 560)
    table.insert(entities, listBox2)
    listBox3 = listbox:new("Done", 500, 20, 220, 560)
    table.insert(entities, listBox3)

    -- mouse
    mouseClicked = false
    vMouse = {x=0, y=0}
    mouseDragging = false
    dragElement = nil
    dragOrigin = nil
    dragDestiny = nil
    mouseControlClicked = nil
    mouseControlHovered = nil

    -- fill the tables with some values
    for i=0, 10 do
        listBox1:addCard("card " .. i)
    end
    for i=0, 4 do
        listBox2:addCard("card " .. i)
    end
    for i=0, 10 do
        listBox3:addCard("card " .. i)
    end
    Selected1, Selected2, Selected3 = nil, nil, nil
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
        mouseDragging = true
		mouseClicked = true
	end
end

function love.mousereleased(x,y,button,istouch)
    if button == 1 and mouseDragging == true then
        if dragOrigin == dragDestiny then return end

        -- get dragElement from dragOrigin list
        -- remove dragElement from dragOrigin list
        -- local elem = nil
        -- if dragOrigin == 1 then
        --     elem = table.remove(todoTable,dragElement)
        -- end
        -- if dragOrigin == 2 then
        --     elem = table.remove(doingTable,dragElement)
        -- end
        -- if dragOrigin == 3 then
        --     elem = table.remove(doneTable,dragElement)
        -- end
        -- -- add dragElement to dragDestiny list
        -- if dragDestiny == 1 then
        --     table.insert(todoTable, elem)
        -- end
        -- if dragDestiny == 2 then
        --     table.insert(doingTable, elem)
        -- end
        -- if dragDestiny == 3 then
        --     table.insert(doneTable, elem)
        -- end

        -- reset
        mouseDragging = false
        dragOrigin = nil
        dragDestiny = nil
        dragElement = nil
    end
end

function love.update(dt)
    -- button 1 20, 20, 220, 50
    -- button 2 260, 20, 220, 50
    -- button 3 500, 20, 220, 20

    -- to do list 20,80, 220, 500

    -- doing list 260, 80, 220, 500

    -- done list 500, 80, 220, 500

    --update the entities
    for i,v in ipairs(entities) do
        v:update(dt)
    end

    mouseClicked = false
end

function love.draw()
    love.graphics.setBackgroundColor(0,0,0)
    love.graphics.setColor(1,1,1)

    -- draw the entities
    for i,v in ipairs(entities) do
        v:draw()
    end

    -- Draw Debug Info
    love.graphics.print("Selected", 730, 0)
    if Selected1 == nil then Selected1 = 0 end
    if Selected2 == nil then Selected2 = 0 end
    if Selected3 == nil then Selected3 = 0 end
    love.graphics.print(Selected1 .. "," .. Selected2 .. "," .. Selected3, 730, 30)
    love.graphics.print("Dragging", 730, 60)
    love.graphics.print(tostring(mouseDragging), 730, 90)
    if mouseControlClicked ~= nil then
        love.graphics.print("Clicked " .. mouseControlClicked, 730, 120)
    end
    if mouseControlHovered ~= nil then
        love.graphics.print("Hover " .. mouseControlHovered, 730, 150)
    end

    --draw UI
end
