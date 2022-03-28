TileMap = Class{}

function TileMap:init(width, height)
    self.tiles = {}
    self.width = width
    self.height = height
end

function TileMap:tileFromCoords(x, y)
    gridx = math.floor(x / QUADX) + 1
    gridy = math.floor(y / QUADY) + 1
    return self.tiles[gridy][gridx] or nil
end

--- check for tile's neighbours
-- a tile is discovered if it has one adjancent
-- colonized tile
function TileMap:discoverNeighbours(tile)
    local search = {{x= 0, y= -1}, {x= 1, y= 0}, {x= 0, y= 1}, {x= -1, y= 0}}

    for i = 1, 4 do
        local neighbour_y, neighbour_x = tile.y + search[i].y, tile.x + search[i].x
        if neighbour_y > 0 and neighbour_x > 0 then
            self.tiles[tile.y + search[i].y][tile.x + search[i].x].state.discovered = true
        end
    end
end

function TileMap:render()
    for y = 1, self.height do
        for x = 1, self.width do
            self.tiles[y][x]:render()
        end
    end
end