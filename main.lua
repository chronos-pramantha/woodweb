require 'src/Dependencies'


function love.load()
    love.window.setTitle('WoodWeb')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gStateStack = StateStack()
    gStateStack:push(playState())

    love.mouse.keysPressed = false

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)

    Timer.update(dt)
    gStateStack:update(dt)

end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end
