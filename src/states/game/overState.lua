overState = Class{__includes = BaseState}


--- game over state
function overState:init()

    self.title = Textbox(
        QUADX * BOARD_SIZE + 15,
        30,
        GUI_SIZE, 
        75,
        "", 
        Fonts['large']
    )

    self.storybox = Textbox(
        QUADX * BOARD_SIZE + 15,
        110,
        GUI_SIZE, 
        200,
        "", 
        Fonts['medium']
    )

    self.hint = Textbox(
        QUADX * BOARD_SIZE + 15,
        315,
        GUI_SIZE, 
        75,
        "", 
        Fonts['medium']
    )

    self.calltoaction = Textbox(
        QUADX * BOARD_SIZE + 15,
        395,
        GUI_SIZE, 
        75,
        "", 
        Fonts['medium']
    )

    self.counters = Textbox(
        QUADX * BOARD_SIZE + 15,
        475,
        GUI_SIZE, 
        WINDOW_HEIGHT - 475,
        "Game Over :( Press Esc to restart", 
        Fonts['large']
    )
end

function overState:update(dt)
    function love.keypressed(key)
        if key == 'escape' then
            gStateStack:pop(overState())
            gStateStack:push(playState())
        end
    end
end

function playState:update(dt)
    self.board:update(dt)
    self.counters = updateCountersPanel(self.board.scores)
end

function overState:render()
    self.title:render()
    self.storybox:render()
    self.hint:render()
    self.calltoaction:render()
    self.counters:render()
end