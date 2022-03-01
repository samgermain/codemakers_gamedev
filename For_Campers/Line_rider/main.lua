require("Camera")

function love.load()
	pause = true

	love.physics.setMeter(32) --the height of a meter our worlds will be 64px
	--Sets the pixels to meter scale factor, All coordinates in the physics module are divided by this number and converted to meters, and it creates a convenient way to draw the objects directly to the screen without the need for graphics transformations. It is recommended to create shapes no larger than 10 times the scale. This is important because Box2D is tuned to work well with shape sizes from 0.1 to 10 meters. The default meter scale is 30. love.physics.setMeter does not apply retroactively to created objects. Created objects retain their meter coordinates but the scale factor will affect their pixel coordinates.
	world = love.physics.newWorld(0, 20*32, true) --The world the everything exists in. Horizontal gravity=0. Bertical gravity=9.81. True says that the world is allowed to sleep.
	
	objects = {} -- table to hold all our physical objects
	objects.lines = {}

-------------------------------------------------------------------------------------------------
	-- [CODE 4 LINES] create your 4 variables drawn_x, drawn_y, oldx and oldy and set them to 0
--------------------------------------------------------------------------------------------------	

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--let's create our tobboggan
	--[CODE 7 LINES]
	--create the rider object and set it equal to {}
	-- Create a body for the object, with coordinates x=325 and y=0
	-- Set the width and height of the rider
	-- Create a shape for the rider, the shape is a rectangle. The rider will orginally be a rectangle but we will place a tobboggan image overtop of the rectangle to show a tobbogan rider moving.
	-- Create a fixture for the rider
	-- Set the friction to 0 using the line objects.rider.fixture:setFriction(0.0)
	-- Set the image of the rider to be images/tobboggan.png
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	--initial graphics setup
	love.graphics.setBackgroundColor(0.41, 0.53, 0.97) --set the background color to blue
	love.window.setMode(1700, 1000) --set the window dimensions to 1700 by 1000
end
 
 
function love.update(dt)
	if not pause then
		world:update(dt) --this puts the world into motion
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- [CODE LINE] Insert a Camera:follow function and pass objects.rider to it
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	else
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- [CODE LINE] Insert a Camera.update function
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	end
 
	--draw lines when the mouse is down
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--[CODE A BUNCH] Code the if statement exactly like how it was coded in the pinball game, but this time add Camera.x and Camera.y to drawn_x and drawn_y
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


end
 
 
function love.draw()

	love.graphics.print(love.timer.getFPS().."\nSpace to play/pause")
 
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- [CODE 7 LINES] 6 for varialbe, 1 for the draw function
	-- draw the rider like the quidditch player was drawn. You need to use love.graphics.draw and have arguments for the image, the x coordinate, the y coordinate, the angle and the x and y orientation
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--[CODE 3 LINES] Code a for loop to draw all the lines created like you did in the last exercise, but subtract Camera.x and Camera.y as applicable
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
end


function love.keypressed(button)
	if button == "space" then
		pause = not pause
	elseif button == "r" then
		objects.rider.body:setPosition(650/2, 0)
		objects.rider.body:setLinearVelocity(0, 0) --we must set the velocity to zero to prevent a potentially large velocity generated by the change in position
		objects.rider.body:setAngle(0)
		pause = true
		Camera.x = 0
		Camera.y = 0
	end
end
