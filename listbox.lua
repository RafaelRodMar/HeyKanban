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

    return entity
end

function listbox:update(dt)
end

function listbox:addCard(text)
    table.insert(self.cards, text)
end

function listbox:draw()
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
end