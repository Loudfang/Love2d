--
-- Created by IntelliJ IDEA.
-- User: user
-- Date: 4/10/2016
-- Time: 10:06 PM
-- To change this template use File | Settings | File Templates.
--

debug = true

player = {x = 200, y = 710, speed = 300, img = nil }

canShoot = true
canShootTimerMax = 0.2
canShootTimer = canShootTimerMax

bulletImg = nil
bullets = {}

createEnemyTimerMax = 0.4
createEnemyTimer = createEnemyTimerMax

enemyImg = nil

enemies= {}



function love.load(arg)

    player.img = love.graphics.newImage('assets/plane.png')
    bulletImg = love.graphics.newImage('assets/bullet.png')
    enemyImg = love.graphics.newImage('assets/enemy.png')

end

function love.update(dt)

    canShootTimer = canShootTimer - (1 * dt)
    if canShootTimer < 0 then
        canShoot = true
    end

    if love.keyboard.isDown(' ', 'rctrl', 'lctrl', 'ctrl') and canShoot then

        newBullet = { x = player.x + (player.img:getWidth()/2), y = player.y, img = bulletImg }
        table.insert(bullets, newBullet)
        canShoot = false
        canShootTimer = canShootTimerMax
    end

    for i, bullet in ipairs(bullets) do
        bullet.y = bullet.y - (250 * dt)

        if bullet.y < 0 then
        table.remove(bullets, i)
        end
    end

    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end

    if love.keyboard.isDown('left','a') then
            if player.x > 0 then
                player.x = player.x - (player.speed * dt)
            end
    elseif love.keyboard.isDown('right','d') then
            if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
                player.x = player.x + (player.speed * dt)
            end

    elseif love.keyboard.isDown('up','w')then
            if player.y > 0 then
                player.y =player.y - (player.speed *dt)
            end

    elseif  love.keyboard.isDown('down','s')then
            if player.y < (love.graphics.getHeight() - player.img:getHeight()) then
                player.y =player.y + (player.speed *dt)
            end

    end


end

function love.draw(dt)

    for i, bullet in ipairs(bullets) do
        love.graphics.draw(bullet.img, bullet.x, bullet.y)
    end


    love.graphics.draw(player.img,player.x,player.y)
end