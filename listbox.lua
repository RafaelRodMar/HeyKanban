listbox = {}

listbox_mt = { __index = listbox }

function listbox:new(name, x, y, w, h)
    local entity = {}
    setmetatable(entity, listbox_mt)
    
    entity.name = name
    entity.posx = x
    entity.posy = y
    entity.width = w
    entity.height = h
    entity.cards = {}
    entity.selected = 0
    entity.hovered = false
    entity.scrollBar = {}
    entity.numVisibleItems = 9
    entity.selectedItem = 1
    entity.visibleItems = {}
    entity.startItem = 1

    -- scrollbar
    -- Initialize ScrollBar
    entity.scrollBar.x = entity.posx + entity.width - 20
    entity.scrollBar.y = entity.posy + 25
    entity.scrollBar.width = 20
    entity.scrollBar.height = entity.height - 25
    entity.scrollBar.thumbHeight = ((entity.height - 25) / #entity.cards) + 5 -- 5 is the separation between cards

    return entity
end

function listbox:update(dt)
end

function listbox:addCard(text)
    table.insert(self.cards, text)
    self:updateListBox()
    self:updateScrollBar()
end

function listbox:mousemoved( x, y )
    self.hovered = false
    if x > self.posx and x < self.posx + self.width and y > self.posy and y < self.posy + self.height then
        self.hovered = true
    end
end

function listbox:mousepressed(x,y)
    -- check if hits a card or the scrollbar controls.
    if x > self.posx + self.width - 20 and x < self.posx + self.width then
        -- it hits the scroll bar.
        self.selectedItem = math.floor((y - self.scrollBar.y) / self.scrollBar.thumbHeight)
        self.selectedItem = math.min(math.max(self.selectedItem, 1), #self.cards)
        self:updateListBox()
        self:updateScrollBar()    
    else
        if x > self.posx and x < self.posx + self.width - 20 and y > self.posy + 25 and y < self.posy + self.height then
            -- calculate the selected item based on the click position
            self.selectedItem = math.floor((y - self.posy + 25) / 55 ) -- 55 is 50 height of card + 5 height of separation
            self.selectedItem = math.min(math.max(self.selectedItem, 1), #self.cards)
        end
        self:updateListBox()
        self:updateScrollBar()    
    end
end

function listbox:updateListBox()
    -- Update the visible items based on the selected item
    self.visibleItems = {}
    self.startItem = math.max(1, self.selectedItem - math.floor(self.numVisibleItems / 2))
    for i = self.startItem, math.min(#self.cards, self.startItem + self.numVisibleItems - 1) do
        table.insert(self.visibleItems, self.cards[i])
    end
end

-- Update the thumb height of the ScrollBar
function listbox:updateScrollBar()
    --self.scrollBar.thumbHeight = self.height / #self.cards
    self.scrollBar.thumbHeight = ((self.height - 25) / #self.cards) + 5 -- 5 is the separation between cards
end

function listbox:draw()
    -- save actual colors
    local bgR, bgG, bgB, bgA = love.graphics.getBackgroundColor()
    local tR, tG, tB, tA = love.graphics.getColor()

    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line", self.posx, self.posy, self.width, self.height)
    love.graphics.print(self.name, self.posx+2, self.posy+2)

    local x = self.posx
    local y = self.posy + 25
    -- Draw items in the ListBox
    for i, item in ipairs(self.visibleItems) do
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("fill", x,y,220,50, 10, 10, 5)
        love.graphics.setColor(0,0,0)
        love.graphics.printf(item, x+2, y+2, 220)
        y = y + 55
    end

    -- draw scroll bar controls
    love.graphics.setColor(0.5,0.5,0.5)
    love.graphics.rectangle("line", self.scrollBar.x, self.scrollBar.y, self.scrollBar.width, self.scrollBar.height)
    love.graphics.setColor(0.8, 0.8, 0.8)
    love.graphics.rectangle("fill", self.scrollBar.x, self.scrollBar.y + self.scrollBar.thumbHeight * (self.selectedItem - 1), self.scrollBar.width, self.scrollBar.thumbHeight)

    -- restore colors
    love.graphics.setBackgroundColor(bgR, bgG, bgB, bgA)
    love.graphics.setColor(tR, tG, tB, tA)
end