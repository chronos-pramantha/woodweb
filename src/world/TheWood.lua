--[[
    The main board
]]

TheWood = Class{}

function TheWood:init()
    self.gridWidth = WOOD_DATA['gridx']
    self.gridHeight = WOOD_DATA['gridy']

    self.map = TileMap(self.gridWidth, self.gridHeight)

    self:create()
end

--- Generate the game map
function TheWood:create()
    -- fill the tilesmap with grass tiles
    -- all tiles are rendered as covered initially
    for y = 1, self.gridHeight do
        table.insert(self.map.tiles, {})
        for x = 1, self.gridWidth do
            if x == math.floor(BOARD_SIZE / 3) and y == math.floor(BOARD_SIZE / 3) then
                local firstTile = Tile(x, y, 1)
                firstTile.state.discovered = true
                table.insert(self.map.tiles[y], firstTile)
            else
                local id = Tile:getRandomId()
                table.insert(self.map.tiles[y], Tile(x, y, id))
            end
        end
    end
end

--- Handle Mouse clicks all-over the screen
function TheWood:mouseClickCallback(mouseX, mouseY, button, istouch)
    if button == 1 then
        print("mouse pressed", button)
        -- broadcast mouse left button pressed
        love.mouse.keysPressed = true
        -- compute clicked tile
        tile = self.map:tileFromCoords(
            love.mouse.getX(), 
            love.mouse.getY()
        )
        -- check if click is in the board and if it is discovered
        if not tile or tile.state.discovered == false then
            love.mouse.keysPressed = true
            return
        end

        -- switch state of the tile if needed, see TileState
        switchedTo = TileState:switch(tile)
        if switchedTo == 'colonized' then
            -- if tile switched to colonized, neighbours should be discovered
            self.map:discoverNeighbours(tile)
        end

        print(tile, tile.state)
    end
end

function TheWood:update(dt)
    function love.mousepressed(mouseX, mouseY, button, istouch)
        self:mouseClickCallback(mouseX, mouseY, button, istouch)
    end

    for tilex, row in pairs(self.map.tiles) do
        -- print(tilex, row)
        -- for tiley in row do
        -- if self.state.colonized then
        --     -- discover neighbours (x+1, y), (x, y+1), (x+1, y+1)
        -- end
    end

    love.mouse.keysPressed = false
end

function TheWood:render()
    self.map:render()
end