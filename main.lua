local Slab = require 'libraries/Slab'
    
function love.load()
    --variables
    appWidth = 800
    appHeight = 600
    love.window.setMode(appWidth, appHeight, {resizable=false, vsync=false})

    entities = {}
    todoTable = {}
    doingTable = {}
    doneTable = {}

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

    Slab.Initialize(args)

    -- fill the tables with some values
    for I = 1, 10, 1 do
        table.insert(todoTable, "Item " .. I)
        table.insert(doingTable, "Item " .. I)
        table.insert(doneTable, "Item " .. I)
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
		mouseClicked = true
	end
end

function love.mousereleased(x,y,button,istouch)
    if button == 1 then
        mouseClicked = false
    end
end

function love.update(dt)
    Slab.Update(dt)

    Slab.BeginWindow('button1Window', {AutoSizeWindow = false, AllowResize = false, X = 20, Y = 20, W = 220, H = 50, BgColor = {1,0,0}})
    Slab.Button("To Do", {W = 215, H = 45 })
    Slab.EndWindow()

    Slab.BeginWindow('button2Window', {AutoSizeWindow = false, AllowResize = false, X = 260, Y = 20, W = 220, H = 50, BgColor = {1,0,0}})
    Slab.Button("Doing", {W = 215, H = 45 })
    Slab.EndWindow()

    Slab.BeginWindow('button3Window', {AutoSizeWindow = false, AllowResize = false, X = 500, Y = 20, W = 220, H = 50, BgColor = {1,0,0}})
    Slab.Button("Done", {W = 215, H = 45 })
    Slab.EndWindow()

    -- to do list

    Slab.BeginWindow('ListBoxWindow1', {AutoSizeWindow = false, AllowResize = false, X = 20, Y = 80, W = 220, H = 500})

    Slab.BeginListBox('ListBox1', {StretchW = true, StretchH = true})
    for I = 1, #todoTable do
        Slab.BeginListBoxItem('ListBox1_Item_' .. I, {Selected = Selected1 == I})
        Slab.Text(todoTable[I])

        if Slab.IsListBoxItemClicked() then
            Selected1 = I
        end

        Slab.EndListBoxItem()
    end

    Slab.EndListBox()

    Slab.EndWindow()

    -- doing list

    Slab.BeginWindow('ListBoxWindow2', {AutoSizeWindow = false, AllowResize = false, X = 260, Y = 80, W = 220, H = 500})

    Slab.BeginListBox('ListBox2', {StretchW = true, StretchH = true})
    for I = 1, #doingTable do
        Slab.BeginListBoxItem('ListBox2_Item_' .. I, {Selected = Selected2 == I})
        Slab.Text(doingTable[I])

        if Slab.IsListBoxItemClicked() then
            Selected2 = I
        end

        Slab.EndListBoxItem()
    end
    Slab.EndListBox()

    Slab.EndWindow()

    -- done list

    Slab.BeginWindow('ListBoxWindow3', {AutoSizeWindow = false, AllowResize = false, X = 500, Y = 80, W = 220, H = 500})

    Slab.BeginListBox('ListBox3', {StretchW = true, StretchH = true})
    for I = 1, #doneTable do
        Slab.BeginListBoxItem('ListBox3_Item_' .. I, {Selected = Selected3 == I})
        Slab.Text(doneTable[I])

        if Slab.IsListBoxItemClicked() then
            Selected3 = I
        end

        Slab.EndListBoxItem()
    end
    Slab.EndListBox()

    Slab.EndWindow()

    --update the entities
    for i,v in ipairs(entities) do
        v:update(dt)
    end
    
    if Selected1 == nil then Selected1 = 0 end
    if Selected2 == nil then Selected2 = 0 end
    if Selected3 == nil then Selected3 = 0 end
    print(Selected1 .. "," .. Selected2 .. "," .. Selected3)
    mouseClicked = false
end

function love.draw()
    love.graphics.setBackgroundColor(0,0,0)

    -- draw the objects
    for i,v in ipairs(entities) do
        v:draw()
    end

    -- Draw Debug Info
    --draw UI
    Slab.Draw()
end
