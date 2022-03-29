Tile = Class{}

function Tile:init(x, y, id, discovered)
    self.x = x
    self.y = y
    self.id = id
    self.state = TileState()
end

function Tile:__tostring()
    return "<Tile: x "..self.x..", y "..self.y..
        ", id "..self.id..">"
end

function Tile:getRandomId()
    local p = math.random()
    local cumulativeProbability = 0
    for name, item in pairs(BONUS_DATA) do
        cumulativeProbability = cumulativeProbability + item
        if p <= cumulativeProbability then
            return TILE_IDS[name]
        end
    end
end

-- function Tile:update(dt)
--     -- if tile has one neighbour `discovered`
--     -- it should be highlighted on mouseover
--     self.state.update()
-- end

function Tile:render()
    if self.state.colonized == true then
        local image = nil
        if self.id == TILE_IDS['grass'] then
            image = ATLAS.sheet[TILE_IDS['colonized']]
        else
            image = ATLAS.sheet[self.id]
        end
        
        -- colonized tiles are full scale
        love.graphics.draw(
            ATLAS.image,
            image,
            (self.x - 1) * ATLAS.tilewidth,
            (self.y - 1) * ATLAS.tileheight,
            0,
            1,
            1
        )
    else
        -- not colonized tiles are dispalyed scaled down
        love.graphics.draw(
            ATLAS.image,
            self.state.discovered and ATLAS.sheet[self.id] or ATLAS.sheet[TILE_IDS['covered']],
            (self.x - 1) * ATLAS.tilewidth,
            (self.y - 1) * ATLAS.tileheight,
            0,
            0.9,
            0.9,
            -ATLAS.tilewidth * 0.1,
            -ATLAS.tileheight * 0.1

        )
    end
end