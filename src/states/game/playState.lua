playState = Class{__includes = BaseState}

function playState:init()
    self.board = TheWood()

    -- print at screen
    self.title = Textbox(
        QUADX * BOARD_SIZE + 15,
        30,
        GUI_SIZE, 
        75,
        storytellingLayout[1]["title"], 
        Fonts['large']
    )

    self.storybox = Textbox(
        QUADX * BOARD_SIZE + 15,
        110,
        GUI_SIZE, 
        200,
        storytellingLayout[1]["story"], 
        Fonts['medium']
    )

    self.hint = Textbox(
        QUADX * BOARD_SIZE + 15,
        315,
        GUI_SIZE, 
        75,
        storytellingLayout[1]["hint"], 
        Fonts['medium']
    )

    self.calltoaction = Textbox(
        QUADX * BOARD_SIZE + 15,
        395,
        GUI_SIZE, 
        75,
        storytellingLayout[1]["calltoaction"], 
        Fonts['medium']
    )

    -- phase counter
    self.storytell = 1
end

function playState:update(dt)
    self.board:update(dt)
    
    love.keyboard.wasPressed = {}
end

function playState:render()
    self.board:render()

    self.title:render()
    self.storybox:render()
    self.hint:render()
    self.calltoaction:render()
end