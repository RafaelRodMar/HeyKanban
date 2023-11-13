require("listbox")
    
function love.load()
    --variables
    appWidth = 900
    appHeight = 600
    love.window.setMode(appWidth, appHeight, {resizable=false, vsync=false})

    entities = {}

    --load font
    font = love.graphics.newFont("sansation.ttf",20)
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

    listBox1 = listbox:new("To do", 20, 20, 240, 560)
    table.insert(entities, listBox1)
    listBox2 = listbox:new("Doing", 280, 20, 240, 560)
    table.insert(entities, listBox2)
    listBox3 = listbox:new("Done", 540, 20, 240, 560)
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
    for i=1, 10 do
        listBox1:addCard("card " .. i)
    end
    for i=1, 4 do
        listBox2:addCard("card " .. i)
    end
    for i=1, 20 do
        listBox3:addCard("card " .. i)
    end
    selected = {0,0,0}
end

function love.keypressed(key)
end

function love.keyreleased(key)
end

function love.mousemoved( x, y, dx, dy, istouch )
    vMouse.x = x
    vMouse.y = y
    for i,v in ipairs(entities) do
        v:mousemoved(vMouse.x, vMouse.y) -- let the controls check if they are hovered
    end
end

function love.mousepressed(x,y,button, istouch)
	if button == 1 then
        mouseDragging = true
		mouseClicked = true

        -- send to controls
        for i,v in ipairs(entities) do
            v:mousepressed(x,y)
        end
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
    mouseControlHovered = nil
    --update the entities
    for i,v in ipairs(entities) do
        v:update(dt)
        -- if control is hovered
        if v.hovered then mouseControlHovered = i end
        selected[i] = v.selectedItem
    end

    mouseClicked = false
end

function love.draw()
    love.graphics.setBackgroundColor(0,0,0) -- black
    love.graphics.setColor(1,1,1) -- white

    -- draw the entities
    for i,v in ipairs(entities) do
        v:draw()
    end

    -- Draw Debug Info
    love.graphics.print("Selected", 800, 0)
    if selected[1] == nil then selected[1] = 0 end
    if selected[2] == nil then selected[2] = 0 end
    if selected[3] == nil then selected[3] = 0 end
    love.graphics.print(selected[1] .. "," .. selected[2] .. "," .. selected[3], 800, 30)
    love.graphics.print("Dragging", 800, 60)
    love.graphics.print(tostring(mouseDragging), 800, 90)
    if mouseControlClicked ~= nil then
        love.graphics.print("Clicked " .. mouseControlClicked, 800, 120)
    end
    if mouseControlHovered ~= nil then
        love.graphics.print("Hover " .. mouseControlHovered, 800, 150)
    end

    --draw UI
end
