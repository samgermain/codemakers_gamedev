require("Camera")

function love.load()
	paused = false
	love.physics.setMeter(64) --the height of a meter our worlds will be 64px
	world = love.physics.newWorld(0, 4.8*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
 
	objects = {} -- table to hold all our physical objects
 
	--let's create the ground
	objects.ground = {}
	objects.ground.x = 1600/2 	-- The x position of the ground
	objects.ground.y = 900-50  -- The y position of the ground
	objects.ground.width = 1000000 -- How long the ground is
	objects.ground.height = 500 -- How tall the ground is
	objects.ground.body = love.physics.newBody(world, objects.ground.x, objects.ground.y + objects.ground.height/2, "static") -- the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (1700/2, 1000-50/2)
		-- we place the ground within our world, set it's position, and make the ground static so it doesn't move
	
	objects.ground.shape = love.physics.newRectangleShape(objects.ground.width, objects.ground.height) --The ground will be a rectangle
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape, 1); --Attach the shape to the body created, give it a density of 1
	
	objects.ramps = {}
	ramp = {}
	ramp.x = 1650
	ramp.y = objects.ground.y
	ramp.width = 200
	ramp.height = 100
	ramp.x2 = ramp.x + ramp.width
	ramp.y2 = ramp.y - ramp.height
	ramp.body = love.physics.newBody(world, 0, 0, "static")		-- For some reason the body has to have x and y coordinates of 0, because the next line put yours objects at offsets from these positions
	ramp.shape = love.physics.newPolygonShape(ramp.x, ramp.y, ramp.x2, ramp.y, ramp.x2, ramp.y2)	-- First 2 arguments are the first corner of the triangle, 3rd and 4th arguments are the second corner of the triangle
	ramp.fixture = love.physics.newFixture(ramp.body, ramp.shape, 1);	-- Attach the shape to the body, give it a density of 1
	table.insert(objects.ramps, ramp)	-- We will keep all our ramps within a table called objects.ramps, this is so we can use the same code over and over again on them

	ramp2 = {}
	ramp2.x = 8000 
	ramp2.y = objects.ground.y
	ramp2.width = 200
	ramp2.height = 100
	ramp2.x2 = ramp2.x + ramp2.width
	ramp2.y2 = ramp2.y - ramp2.height
	ramp2.body = love.physics.newBody(world, 0, 0, "static")
	ramp2.shape = love.physics.newPolygonShape(ramp2.x, ramp2.y, ramp2.x2, ramp2.y, ramp2.x2, ramp2.y2)
	ramp2.fixture = love.physics.newFixture(ramp2.body, ramp2.shape, 1);
	table.insert(objects.ramps, ramp2)

	ramp3 = {}
	ramp3.x = 13000 
	ramp3.y = objects.ground.y
	ramp3.width = 200
	ramp3.height = 100
	ramp3.x2 = ramp3.x + ramp3.width
	ramp3.y2 = ramp3.y - ramp3.height
	ramp3.body = love.physics.newBody(world, 0, 0, "static")
	ramp3.shape = love.physics.newPolygonShape(ramp3.x, ramp3.y, ramp3.x2, ramp3.y, ramp3.x2, ramp3.y2)
	ramp3.fixture = love.physics.newFixture(ramp3.body, ramp3.shape, 1);
	table.insert(objects.ramps, ramp3)

	objects.hoops = {}
	hoop = {}
	hoop.img = love.graphics.newImage('images/quidditch_hoop.png')	-- Accessing a picture of our quidditch hoops from within our files
	hoop.x = 2450
	hoop.y = objects.ground.y - hoop.img:getHeight()	-- We want the hoop to be touching the ground which is why it's positioned at objects.ground.y
														-- We subtract hoop.img:getHeight() because otherwise the hoop will be half in the ground and half in the sky. Try commenting out - hoop.img:getHeight() and see what happens!
	table.insert(objects.hoops, hoop)	-- all our quidditch hoops are kept within objects.hoops, so that we can perform the same operation on each of them

	hoop2 = {}
	hoop2.img = love.graphics.newImage('images/quidditch_hoop.png')
	hoop2.x = 8900
	hoop2.y = objects.ground.y - hoop2.img:getHeight()
	table.insert(objects.hoops, hoop2)

	hoop3 = {}
	hoop3.img = love.graphics.newImage('images/quidditch_hoop.png')
	hoop3.x = 14300
	hoop3.y = objects.ground.y - hoop3.img:getHeight()
	table.insert(objects.hoops, hoop3)

--	hoop4 = {}
--	hoop4.img = love.graphics.newImage('images/quidditch_hoop.png')
--	hoop4.x = 5000
--	hoop4.y = objects.ground.y - hoop4.img:getHeight()
--	table.insert(objects.hoops, hoop4)

--	hoop5 = {}
--	hoop5.img = love.graphics.newImage('images/quidditch_hoop.png')
--	hoop5.x = 11000
--	hoop5.y = objects.ground.y - hoop5.img:getHeight()
--	table.insert(objects.hoops, hoop5)
	
--	hoop6 = {}
--	hoop6.img = love.graphics.newImage('images/quidditch_hoop.png')
--	hoop6.x = 15000
--	hoop6.y = objects.ground.y - hoop6.img:getHeight()
--	table.insert(objects.hoops, hoop6)
	
--	hoop7 = {}
--	hoop7.img = love.graphics.newImage('images/quidditch_hoop.png')
--	hoop7.x = 17000
--	hoop7.y = objects.ground.y - hoop7.img:getHeight()
--	table.insert(objects.hoops, hoop7)
	
	--let's create a wizard
	objects.wizard = {}
	objects.wizard.x = 1700/2	--Our wizard will be positioned in the middle of the scrren to start
	objects.wizard.y = 1000/2
	objects.wizard.width = 100
	objects.wizard.height = 70

	objects.wizard.body = love.physics.newBody(world, objects.wizard.x, objects.wizard.y, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
	objects.wizard.shape = love.physics.newRectangleShape(objects.wizard.width, objects.wizard.height) --The wizard will actually just be a rectangle, but we will insert an image over it
	objects.wizard.fixture = love.physics.newFixture(objects.wizard.body, objects.wizard.shape, 1) -- Attach fixture to body and give it a density of 1.
	objects.wizard.img = love.graphics.newImage('images/wizard.png')	--Access a picture from our filesystem

	--initial graphics setup
	love.graphics.setBackgroundColor(0.41, 0.53, 0.97) --set the background color to a nice blue
	love.window.setMode(1600, 900) --set the window dimensions to 650 by 650
end

function love.update(dt)
	
	--Camera.update(dt)	-- Runs the update function from the camera file, it makes it so that the position of the camera on the screen changes if one of the keys is down
	
	if not paused then
		Camera:follow(dt, objects.wizard)
		world:update(dt) --this puts the world into motion
	else
		Camera.update(dt)
	end
	
 -------------------------------------------------------------------------------------------------------------------
	--here we are going to program movment into the wizard
	if love.keyboard.isDown("left") then --press the right arrow key to push the wizard to the right
		objects.wizard.body:applyForce(-600, 0)	-- this force will move the wizard forward
	elseif love.keyboard.isDown("right") then --press the right arrow key to push the wizard to the right
		objects.wizard.body:applyForce(600, 0)	-- this force will move the wizard forward
	elseif love.keyboard.isDown("up") then --press the right arrow key to push the wizard to the right
		objects.wizard.body:applyForce(0, -1000)	-- this force will move the wizard forward
	elseif love.keyboard.isDown("down") then --press the right arrow key to push the wizard to the right
		objects.wizard.body:applyForce(0, 1000)	-- this force will move the wizard forward

		
---------------------------------------------------------------------------------------------------------------------
		-- do the same thing with the other 3 directions, you may need to give the up movement more force than 600
---------------------------------------------------------------------------------------------------------------------
	--elseif love.keyboard.isDown("r") then --press r key to restart and set the wizard back to the start
	--	objects.wizard.body:setPosition(650/2, 650/2)
	--	objects.wizard.body:setLinearVelocity(0, 0) --we must set the velocity to zero to prevent a potentially large velocity generated by the change in position
	end
	objects.wizard.body:setAngularVelocity(0)
end
 
function love.draw()
	love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
	
	for _, ramp in pairs(objects.ramps) do	-- Apply the code within this loop to each one of our ramps
		-- Draw a triangle, 'fill' means fill the inside of the triangle instead of just having an outline, The position of the ramp will continually change which is why we subtract Camera.x and Camera.y
		-- The width of the screen is only 1700, so if ramp.x is 1900 and Camera.x is 250, when we subtract Camera.x from ramp.x, this means that the ramp will be on the scren
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
		--subtract Camera.x and Camera.y from each of the ramp corners x and y positions, This will continually change the positions of the ramp, and look like movement
		love.graphics.polygon('fill', ramp.x - Camera.x, ramp.y - Camera.y, ramp.x2 - Camera.x, ramp.y - Camera.y, ramp.x2 - Camera.x, ramp.y2 - Camera.y)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	end
 
	-- draw the ground
------------------------------------------------------------------------------------------------------------------------------------------------
	--Subtract Camera.x and Camera.y from the ground's x and y positions
	love.graphics.rectangle("fill", objects.ground.x - 750 - Camera.x, objects.ground.y - Camera.y, objects.ground.width, objects.ground.height) 
-------------------------------------------------------------------------------------------------------------------------------------------------
	-- redraw the wizard, with the object moved relative to the camera
	love.graphics.setColor(255, 255, 255)
	img = objects.wizard.img
	
----------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- We change the position of the wizard by subtracting the number stored in Camera.x from the wizard's x position.
	-- We also change the position of the screen, so that it looks like the wizard is stationary while the screen is moving past them.
	x_pos = objects.wizard.body:getX() - Camera.x 
	y_pos = objects.wizard.body:getY() - Camera.y
----------------------------------------------------------------------------------------------------------------------------------------------------------

	angle = objects.wizard.body:getAngle()	-- Remember that the wizard is actually a rectangle behind the screens. The rectangle rolls around, and we can use the direction the rectangle is facing to change the way the wizard is facing
	orient_x = objects.wizard.img:getWidth()/2 -- This makes it so that the center of the picture is the center of gravity
	orient_y = objects.wizard.img:getHeight()/2
	love.graphics.draw(img, x_pos, y_pos, angle, 1, 1, orient_x, orient_y )	-- draws the wizard onto the screen
 
	for _, hoop in pairs(objects.hoops) do
		-- Draw each hoop on the screen, they don't do anything, but it's nice to try to go through them.
----------------------------------------------------------------------------------------------------------------------------------------------------------
		-- subtract Camera.x and camer.y from the hoop's x and y position's, in order to move the hoop with the Camera.
		love.graphics.draw(hoop.img, hoop.x - Camera.x, hoop.y/2 - Camera.y, 0, 2)
-----------------------------------------------------------------------------------------------------------------------------------------------------------
	end
 
end

function love.keypressed(key)

	if key=="p" then
		paused = not paused
	elseif key=="r" then
		objects.wizard.body:setPosition(650/2, 650/2)
		objects.wizard.body:setLinearVelocity(0, 0) --we must set the velocity to zero to prevent a potentially large velocity generated by the change in position
		objects.wizard.body:setAngle(0)
	end

end