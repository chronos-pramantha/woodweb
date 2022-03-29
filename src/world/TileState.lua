--[[
   State-machine for the tile.
   Accessor method `switch` to change state:
   
   States:
   1. covered (f, f)
   2. discovered (t, f)
   3. colonized (t, t) (discover nearest neighbours)

]]

TileState = Class{}

function TileState:init()
    self.discovered = false
    self.colonized = false
end

function TileState:__tostring()
    return "<TileState: " ..
        "discovered "..tostring(self.discovered)..
        ", colonized "..tostring(self.colonized)..
        ">"
end

--- Static method: switch tile state
function TileState:switch(tile)
    -- reclick on a colonized tile
    if tile.state.colonized == true then
        return
    end

    -- a neighbouring tile has been colonised
    if tile.state.discovered == false then
        print("switched to discovered")
        tile.state.discovered = true
        return "discovered"
    end

    -- a discovered tile is being colonized
    if tile.state.discovered == true then
        -- water tiles cannot be colonized
        if tile.id ~= TILE_IDS["water"] then
            print("switched to colonized")
            tile.state.colonized = true
            return "colonized"
        end
    end
end
