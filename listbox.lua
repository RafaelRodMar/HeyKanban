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
    entity.selected = nil
    entity.hovered = false

    return entity
end

function listbox:update(dt)
end

function listbox:addCard(text)
    table.insert(self.cards, text)
end

function listbox:mousemoved( x, y )
    self.hovered = false
    if x > self.posx and x < self.posx + self.width and y > self.posy and y < self.posy + self.height then
        self.hovered = true
    end
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
    for i=1, #self.cards do
        if y + 50 > self.posy + self.height then break end
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("fill", x, y, 220, 50)
        love.graphics.setColor(0,0,0)
        love.graphics.printf(self.cards[i], x+2, y+2, 220)
        y = y + 55
    end

    -- restore colors
    love.graphics.setBackgroundColor(bgR, bgG, bgB, bgA)
    love.graphics.setColor(tR, tG, tB, tA)
end