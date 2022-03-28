--[[
   A class to handle a spritesheet (atlas)
]]

Atlas = Class{}

function Atlas:init(filepath, tilewidth, tileheight)
    -- source image
    self.image = love.graphics.newImage(filepath)
    self.tilewidth = tilewidth
    self.tileheight = tileheight
    self.sheet = nil
end

--- Generate a table from this atlas
function Atlas:setSheet()
    local sheetwidth = self.image:getWidth() / self.tilewidth
    local sheetheight = self.image:getHeight() / self.tileheight

    local counter = 1
    local spritesheet = {}

    for y = 0, sheetheight - 1 do
        for x = 0, sheetwidth - 1 do
            spritesheet[counter] =
                love.graphics.newQuad(
                    x * self.tilewidth,
                    y * self.tileheight,
                    self.tilewidth,
                    self.tileheight,
                    self.image:getDimensions()
                )
            counter = counter + 1
        end
    end

    self.sheet = spritesheet
end