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

    self.counters = nil

    -- phase counter
    self.storytellPhase = 1
end

function updateCounters(scores)
    local tt = "\n"
    for k, v in pairs(scores) do
        tt = tt .. string.format('%s: %d\n', k, v)
    end

    return Textbox(
        QUADX * BOARD_SIZE + 15,
        475,
        GUI_SIZE, 
        WINDOW_HEIGHT - 475,
        tt, 
        Fonts['large']
    )
end

function playState:update(dt)
    self.board:update(dt)
    self.counters = updateCounters(self.board.scores)
end

function playState:render()
    self.board:render()

    self.title:render()
    self.storybox:render()
    self.hint:render()
    self.calltoaction:render()
    self.counters:render()
end