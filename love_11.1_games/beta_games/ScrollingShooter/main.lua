-- Timers
-- We declare these here so we don't have to edit them multiple places
canShoot = true
canShootTimerMax = 0.2 
canShootTimer = canShootTimerMax

-- Image Storage
bulletImg = nil

-- Entity Storage
bullets = {} -- array of current bullets being drawn and updated

debug = true	--flip to false before release
	--determines wheather or not to write things like frames per second to screen

isAlive = true
score = 0 
	
--playerImg = nil	--initialize to nothing
player = { x = 200, y = 800, speed = 200, img = nil}

--More timers
createEnemyTimerMax = 0.4
createEnemyTimer = createEnemyTimerMax
  
-- More images
enemyImg = nil -- Like other images we'll pull this in during out love.load function
  
-- More storage
enemies = {} -- array of current enemies on screen

function love.load(arg)		--Called when game first starts
	player.img = love.graphics.newImage('assets/plane.png')	--Makes this asset ready to be used
	enemyImg = love.graphics.newImage('assets/bernie_sandross_no_background.png')
	bulletImg = love.graphics.newImage('assets/bullet.png')
end

function love.update(dt)	--Called on every frame, dt=delta_time(a measure of how much time has passed since the last call)
	
	-- Exit the game
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

	if love.keyboard.isDown('left','a') then
		if player.x > 0 then -- binds us to the map
			player.x = player.x - (player.speed*dt)
		end
	elseif love.keyboard.isDown('right','d') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then -- binds us to the map
			player.x = player.x + (player.speed*dt)
		end
	end							--multiply timers by these values

	-- Time out how far apart our shots can be.
	canShootTimer = canShootTimer - (1 * dt)
	if canShootTimer < 0 then
		canShoot = true
	end

	if love.keyboard.isDown('space', 'rctrl', 'lctrl') and canShoot then
	-- Create some bullets
		newBullet = {img = bulletImg, x = player.x + (player.img:getWidth()/2) - bulletImg:getWidth()/2, y = player.y, sx = 0.3, sy = 0.3 }
		table.insert(bullets, newBullet)
		canShoot = false
		canShootTimer = canShootTimerMax
	end
	
	-- update the positions of bullets
	for i, bullet in ipairs(bullets) do
		bullet.y = bullet.y - (250 * dt)
	
	  	if bullet.y < 0 then -- remove bullets when they pass off the screen
			table.remove(bullets, i)
		end
	end
	
	createEnemyTimer = createEnemyTimer - (1 * dt)
	if createEnemyTimer < 0 then
		createEnemyTimer = createEnemyTimerMax

		-- Create an enemy
		randomNumber = math.random(10, love.graphics.getWidth() - 10)
		newEnemy = { x = randomNumber, y = -10, img = enemyImg }
		table.insert(enemies, newEnemy)
	end

	for i, enemy in ipairs(enemies) do
		enemy.y = enemy.y + (200 * dt)

		if enemy.y > 850 then -- remove enemies when they pass off the screen
			table.remove(enemies, i)
		end
	end
	
	-- run our collision detection
	-- Since there will be fewer enemies on screen than bullets we'll loop them first
	-- Also, we need to see if the enemies hit our player
	for i, enemy in ipairs(enemies) do
		for j, bullet in ipairs(bullets) do
			if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then
				table.remove(bullets, j)
				table.remove(enemies, i)
				score = score + 1
			end
		end

		if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), player.x, player.y, player.img:getWidth(), player.img:getHeight()) 
		and isAlive then
			table.remove(enemies, i)
			isAlive = false
		end
	end
	
	if not isAlive and love.keyboard.isDown('r') then
		-- remove all our bullets and enemies from screen
		bullets = {}
		enemies = {}

		-- reset timers
		canShootTimer = canShootTimerMax
		createEnemyTimer = createEnemyTimerMax

		-- move player back to default position
		player.x = 50
		player.y = 710

		-- reset our game state
		score = 0
		isAlive = true
	end
	
end

function love.draw(dt)		--Called on every frame
	if isAlive then
		love.graphics.draw(player.img, player.x, player.y-player.img:getHeight())
	else
		love.graphics.print("Press 'R' to restart", love.graphics:getWidth()/2-50, love.graphics:getHeight()/2-10)
	end
	for i, bullet in ipairs(bullets) do
		love.graphics.draw(bullet.img, bullet.x, bullet.y)
	end
	for i, enemy in ipairs(enemies) do
		love.graphics.draw(enemy.img, enemy.x, enemy.y)
	end
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return x1 < x2+w2 and
		x2 < x1+w1 and
		y1 < y2+h2 and
		y2 < y1+h1
end