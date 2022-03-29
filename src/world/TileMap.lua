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
            self.tiles[neighbour_y][neighbour_x].state.discovered = true
        end
    end
end

--- check if tile is sorrounded by at least 3 colonized neighbours
function TileMap:neighboursAreColonized(x, y)
    local search = {{x= 0, y= -1}, {x= 1, y= 0}, {x= 0, y= 1}, {x= -1, y= 0}}
    local neighbours_count = 0

    for i = 1, 4 do
        local neighbour_y, neighbour_x = y + search[i].y, x + search[i].x
        if neighbour_y > 0 and neighbour_x > 0 then  -- check neighbour is in the board
            if self.tiles[neighbour_y][neighbour_x].state.colonized == true then
                neighbours_count = neighbours_count + 1
            end
        end
    end

    if neighbours_count > 2 then
        return true
    end
    return false
end

--- a tile with three colonized neighbours
-- get automatically colonized
function TileMap:autoColonize(tile)
    local search = {{x= 0, y= -1}, {x= 1, y= 0}, {x= 0, y= 1}, {x= -1, y= 0}}

    for i = 1, 4 do
        local neighbour_y, neighbour_x = tile.y + search[i].y, tile.x + search[i].x
        -- check all neighbours of current tile
        if neighbour_y > 0 and neighbour_x > 0 then  -- check neighbour is in the board
            if self:neighboursAreColonized(neighbour_x, neighbour_y) then
                self.tiles[neighbour_y][neighbour_x].state.colonized = true    
            end
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