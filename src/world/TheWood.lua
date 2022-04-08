--[[
    The main board
]]

TheWood = Class{}

function TheWood:init()
    self.gridWidth = WOOD_DATA['gridx']
    self.gridHeight = WOOD_DATA['gridy']

    self.map = TileMap(self.gridWidth, self.gridHeight)

    self.scores = {
        ["moves left"] = 7,  -- available moves
        ["time"] = 0,
        ["colonized"] = 0,
        ["trees connected"] = 0,
        ["stomps connected"] = 0
    }

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

function TheWood:reset()
    self.map = TileMap(self.gridWidth, self.gridHeight)
    self:create()  
end


function TheWood:computeTileScore(tile)
    -- if tree is colonized, add two moves
    if tile.id == TILE_IDS["tree"] then
        self.scores['moves left'] = self.scores['moves left'] + 1
    elseif tile.id == TILE_IDS["stomps"] then
        self.scores['moves left'] = self.scores['moves left'] + 3
    else
        self.scores['moves left'] = self.scores['moves left'] - 1
        -- outof moves
        if self.scores['moves left'] < 1 then
            gStateStack:push(overState())
            self:reset()
        end
    end
end

--- Handle Mouse clicks all-over the screen
function TheWood:mouseActionCallback(mouseX, mouseY, button, istouch)
    if button == 1 then

        -- broadcast mouse left button pressed
        love.mouse.keysPressed = true
        -- compute clicked tile
        local tile = self.map:tileFromCoords(
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
        if switchedTo == nil then
            return
        end
        if switchedTo == 'colonized' then
            -- if tile switched to colonized, neighbours should be discovered
            self.map:discoverNeighbours(tile)
            -- check sorrounded tiles
            self.map:autoColonize(tile)
            -- time passes
            self.scores['time'] = self.scores['time'] + 1
            -- compute score according to colonised tile
            local t = table.shallow_copy(tile)
            self:computeTileScore(t)
        end
    end
end

function TheWood:checkScore()
    local colonised = 0
    local connected_trees = 0
    local connected_stomps = 0
    for _, row in pairs(self.map.tiles) do
        for _, tiley in pairs(row) do
            if tiley.state.discovered and tiley.state.colonized then
                colonised = colonised + 1
            end
            if tiley.state.colonized and tiley.id == TILE_IDS['tree'] then
                connected_trees = connected_trees + 1
            end
            if tiley.state.colonized and tiley.id == TILE_IDS['stomps'] then
                connected_stomps = connected_stomps + 1
            end
        end
    end
    self.scores['colonized'] = colonised
    self.scores['trees connected'] = connected_trees
    self.scores['stomps connected'] = connected_stomps
end


function TheWood:update(dt)
    -- player action handling
    function love.mousereleased(mouseX, mouseY, button, istouch)
        self:mouseActionCallback(mouseX, mouseY, button, istouch)
    end

    -- check state of the board and update scoreboard
    self:checkScore()

    -- reset mouse clicked check
    love.mouse.keysPressed = false
end

function TheWood:render()
    self.map:render()
end