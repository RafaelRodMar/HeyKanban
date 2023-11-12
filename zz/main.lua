-- main.lua

local listBox = {}
local items = {}
local scrollBar = {}
local numVisibleItems = 5
local selectedItem = 1

function love.load()
    love.window.setTitle("ListBox with ScrollBar")
    love.window.setMode(400, 300, {resizable=true})

    -- Populate items in the ListBox
    for i = 1, 20 do
        table.insert(items, "Item " .. i)
    end

    -- Initialize ListBox
    listBox.x = 50
    listBox.y = 50
    listBox.width = 200
    listBox.height = 150

    -- Initialize ScrollBar
    scrollBar.x = listBox.x + listBox.width + 10
    scrollBar.y = listBox.y
    scrollBar.width = 20
    scrollBar.height = listBox.height
    scrollBar.thumbHeight = listBox.height / #items
end

function love.update(dt)
    -- Update the ListBox and ScrollBar
    updateListBox()
    updateScrollBar()
end

function love.draw()
    -- Draw ListBox
    love.graphics.setColor(0.7, 0.7, 0.7)
    love.graphics.rectangle("fill", listBox.x, listBox.y, listBox.width, listBox.height)

    -- Draw items in the ListBox
    love.graphics.setColor(0, 0, 0)
    for i, item in ipairs(visibleItems) do
        love.graphics.print(item, listBox.x + 10, listBox.y + 20 * i)
    end

    -- Draw ScrollBar
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", scrollBar.x, scrollBar.y, scrollBar.width, scrollBar.height)
    love.graphics.setColor(0.8, 0.8, 0.8)
    love.graphics.rectangle("fill", scrollBar.x, scrollBar.y + scrollBar.thumbHeight * (selectedItem - 1), scrollBar.width, scrollBar.thumbHeight)
end

function love.mousepressed(x, y, button, istouch, presses)
    -- Check if the click is inside the ListBox
    if x >= listBox.x and x <= listBox.x + listBox.width and y >= listBox.y and y <= listBox.y + listBox.height then
        -- Calculate the selected item based on the click position
        selectedItem = math.floor((y - listBox.y) / 20) + 1
        selectedItem = math.min(math.max(selectedItem, 1), #items)
    end

    -- Check if the click is inside the ScrollBar
    if x >= scrollBar.x and x <= scrollBar.x + scrollBar.width and y >= scrollBar.y and y <= scrollBar.y + scrollBar.height then
        -- Calculate the selected item based on the click position
        selectedItem = math.floor((y - scrollBar.y) / scrollBar.thumbHeight) + 1
        selectedItem = math.min(math.max(selectedItem, 1), #items)
    end
end

function updateListBox()
    -- Update the visible items based on the selected item
    local startItem = math.max(1, selectedItem - math.floor(numVisibleItems / 2))
    visibleItems = {}
    for i = startItem, math.min(#items, startItem + numVisibleItems - 1) do
        table.insert(visibleItems, items[i])
    end
end

function updateScrollBar()
    -- Update the thumb height of the ScrollBar
    scrollBar.thumbHeight = listBox.height / #items
end
