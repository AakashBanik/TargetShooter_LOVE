function love.load()
-- define globals
    target = {}
    target.x = 300
    target.y = 300
    target.radius = 50

    sprites = {}
    sprites.sky = love.graphics.newImage('sprites/sky.png')
    sprites.target = love.graphics.newImage('sprites/target.png')
    sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')

    score = 0
    timer = 0
    gameState = 1
    highScore = 0

    gameFont = love.graphics.newFont(30)

    love.mouse.setVisible(false)
end 

function love.update(dt) -- delta time
-- game loop
    if gameState == 2 then
        if timer > 0 then
            timer = timer - dt
        end
        if timer < 0 then
            timer = 0
            if score >= highScore then
                highScore = score
            end
            gameState = 1
        end
    end
end

function love.draw()
-- draw graphics to the screen
    
    love.graphics.draw(sprites.sky, 0,0)

    --for score fonts
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: " .. score, 5 , 5)
    love.graphics.print("Timer: " .. math.ceil(timer), 305 , 5)
    love.graphics.print("High Score: " .. highScore, 500, 5)

    -- main 
    if gameState == 1 then
        love.graphics.printf("Click Anywhere To Begin", 0, 250, love.graphics.getWidth(), "center")
    end


    -- draw sprites
    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x-target.radius-10, target.y-target.radius-10)
    end
    love.graphics.draw(sprites.crosshairs, love.mouse.getX()-20, love.mouse.getY()-20)
    
end

function love.mousepressed( x, y, button, istouch, presses )
    
    if button == 1 and gameState == 2 then
        local mousePosToTarget = distance(x,y, target.x, target.y)

        if(mousePosToTarget <= target.radius) then
            score = score + 1
            target.x = math.random(target.radius, love.graphics.getWidth()-target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight()-target.radius)
        end

        if(mousePosToTarget >= target.radius) then
            score = score - 1
            target.x = math.random(target.radius, love.graphics.getWidth()-target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight()-target.radius)
        end

    elseif button == 1 and gameState == 1 then
        gameState = 2
        timer = 10
        score = 0
    end
end

function distance(x1, y1, x2, y2)
    d=math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
    
    return d
end