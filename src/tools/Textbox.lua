Textbox = Class{}

function Textbox:init(x, y, width, height, text, font)
    self.panel = Panel(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.text = text
    self.font = font or Fonts['small']

    self.closed = false

    self.displayingChunks = {}

    --- generate chunks from text
    _, self.textChunks = self.font:getWrap(self.text, self.width - 12)
end

function Textbox:update(dt)
    self.displayingChunks = self:nextChunks()
    -- if love.keyboard.wasPressed('space') or love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    --     self.closed = true
    -- end
    
end

function Textbox:nextChunks()
    local chunks = {}

    for i = self.chunkCounter, self.chunkCounter + 2 do
        table.insert(chunks, self.textChunks[i])

        -- if we've reached the number of total chunks, we can return
        if i == #self.textChunks then
            self.endOfText = true
            return chunks
        end
    end

    self.chunkCounter = self.chunkCounter + 3

    return chunks
end

function Textbox:isClosed()
    return self.closed
end

function Textbox:render()
    self.panel:render()

    love.graphics.setFont(self.font)
    love.graphics.printf(self.text, self.x + 3, self.y + 3, 380)
end