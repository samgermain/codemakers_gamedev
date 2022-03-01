require("Camera")
require("eraser")

function love.load()
	pause = true
	eraser = false
	
	love.physics.setMeter(32) --the height of a meter our worlds will be 32px
	--Sets the pixels to meter scale factor, All coordinates in the physics module are divided by this number and converted to meters, and it creates a convenient way to draw the directly to the screen without the need for graphics transformations. It is recommended to create shapes no larger than 10 times the scale. This is important because Box2D is tuned to work well with shape sizes from 0.1 to 10 meters. The default meter scale is 30. love.physics.setMeter does not apply retroactively to created  Created retain their meter coordinates but the scale factor will affect their pixel coordinates.
	world = love.physics.newWorld(0, 20*32, true) --The world the everything exists in. Horizontal gravity=0. Bertical gravity=9.81. True says that the world is allowed to sleep.
	
	lines = {}

-------------------------------------------------------------------------------------------------
	-- [CODE 4 LINES] create your 4 variables drawn_x, drawn_y, oldx and oldy and set them to 0
	drawn_x = 0	--position to be drawn on when the mouse is pressed
	drawn_y = 0	--position to be drawn on when the mouse is pressed
	oldx = 0
	oldy = 0
--------------------------------------------------------------------------------------------------	

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--let's create our tobboggan
	--[CODE 7 LINES]
	--create the rider object and set it equal to {}
	rider = {}
	-- Create a body for the object, with coordinates x=325 and y=0
	rider.body = love.physics.newBody(world, 650/2, 0, "dynamic") --Determines where the object will start. In the center of the world and dynamic(moves around)
	-- Set the width and height of the rider
	rider.width = 40
	rider.height = 30
	-- Create a shape for the rider, the shape is a rectangle. The rider will orginally be a rectangle but we will place a tobboggan image overtop of the rectangle to show a tobbogan rider moving.
	rider.shape = love.physics.newRectangleShape(rider.width, rider.height) --the ball's shape has a radius of 20
	-- Create a fixture for the rider
	rider.fixture = love.physics.newFixture(rider.body, rider.shape) -- Attach fixture to body and give it a density of 1.
	-- Set the friction to 0 using the line rider.fixture:setFriction(0.0)
	rider.fixture:setFriction(0.0)
	-- Set the image of the rider to be images/tobboggan.png
	rider.img = love.graphics.newImage("images/tobboggan.png")
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	--initial graphics setup
	love.graphics.setBackgroundColor(0.41, 0.53, 0.97) --set the background color to blue
	love.window.setMode(1600, 900) --set the window dimensions to 1700 by 1000
end
 
 
function love.update(dt)
	if not pause then
		world:update(dt) --this puts the world into motion
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- [CODE LINE] Insert a Camera:follow function
		Camera:follow(dt,rider)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	else
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- [CODE LINE] Insert a Camera.update function
		Camera.update(dt)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	end
 
	--draw lines when the mouse is down
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[CODE A BUNCH] Code the if statement exactly like how it was coded in the pinball game, but this time add Camera.x and Camera.y to drawn_x and drawn_y
	if love.mouse.isDown(1) then --and eraser == false then
		drawn_x = love.mouse.getX() + Camera.x	--x coordinate of the mouse
		drawn_y = love.mouse.getY() + Camera.y	--y coordinate of the mouse

		if oldx ~= nil then
			line = {}
			line.x1 = oldx
			line.x2 = drawn_x
			line.y1 = oldy
			line.y2 = drawn_y
			line.body = love.physics.newBody(world, 0, 0, "static")
			line.shape = love.physics.newEdgeShape(drawn_x, drawn_y, oldx, oldy)
			line.fixture = love.physics.newFixture(line.body, line.shape, 5)
			table.insert(lines, line) 
		end
	
		oldx = drawn_x
		oldy = drawn_y
	else
		oldx = nil
		oldy = nil
	end
	
	erase()
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
 
function love.draw()

	love.graphics.print(love.timer.getFPS().."\nSpace to play/pause\nr to restart\nLeft Click to draw\nRight Click To Erase")
 
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- [CODE 7 LINES] 6 for varialbe, 1 for the draw function
	-- draw the rider like the quidditch player was drawn. You need to use love.graphics.draw and have arguments for the image, the x coordinate, the y coordinate, the angle and the x and y orientation
	rider_img = rider.img
	rider_x = rider.body:getX() - Camera.x
	rider_y = rider.body:getY() - Camera.y
	rider_angle = rider.body:getAngle()
	orient_x = rider.img:getWidth()/2
	orient_y = rider.img:getHeight()/2
	love.graphics.draw(rider_img, rider_x, rider_y, rider_angle, 1, 1, orient_x, orient_y )
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--[CODE 3 LINES] Code a for loop to draw all the lines created like you did in the last exercise, but subtract Camera.x and Camera.y as applicable
	for _, line in pairs(lines) do
		love.graphics.line( line.x1 - Camera.x, line.y1 - Camera.y, line.x2 - Camera.x, line.y2 - Camera.y) 
	end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
end






function love.keypressed(button)
	if button == "space" then
		pause = not pause
	elseif button == "r" then
		rider.body:setPosition(650/2, 0)
		rider.body:setLinearVelocity(0, 0) --we must set the velocity to zero to prevent a potentially large velocity generated by the change in position
		rider.body:setAngle(0)
		pause = true
		Camera.x = 0
		Camera.y = 0
	end
end