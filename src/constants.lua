
-- VIRTUAL_WIDTH = 384
-- VIRTUAL_HEIGHT = 216

QUADX, QUADY = 48, 48
BOARD_SIZE = 19
GUI_SIZE = 400

WINDOW_WIDTH = QUADX * BOARD_SIZE + GUI_SIZE + 30
WINDOW_HEIGHT = QUADY * BOARD_SIZE

-- Load spritesheet as a global variable
ATLAS = Atlas('assets/basic_tiles_48x48x9__0_2.png', QUADX, QUADY)
ATLAS:setSheet()

TILE_IDS = {
    ['grass'] = 1,
    ['colonized'] = 2,
    ['stomps'] = 3,
    ['tree'] = 5,
    ['water'] = 6,
    ['covered'] = 7
}

-- presence of bonuses/maluses
BONUS_DATA = {
    ['grass'] = 0.68,
    ['tree'] = 0.20,
    ['water'] = 0.12,
    ['stomps'] = 0.02
}

WOOD_DATA = {
    ['gridx'] = BOARD_SIZE,
    ['gridy'] = BOARD_SIZE,
    ['gridtot'] = BOARD_SIZE * BOARD_SIZE
}

Fonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}


function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end
