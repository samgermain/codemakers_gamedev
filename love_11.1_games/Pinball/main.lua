
function love.load()
	drawn_x = 0	--position to be drawn on when the mouse is pressed
	drawn_y = 100	--position to be drawn on when the mouse is pressed
	oldx = 0	-- the previous position that the mouse was on
	oldy = 0	-- the previous position that the mouse was on
	pause = true

	love.physics.setMeter(32) --the height of a meter our worlds will be 32px
	--Sets the pixels to meter scale factor, All coordinates in the physics module are divided by this number and converted to meters, and it creates a convenient way to draw the objects directly to the screen without the need for graphics transformations. It is recommended to create shapes no larger than 10 times the scale. This is important because Box2D is tuned to work well with shape sizes from 0.1 to 10 meters. The default meter scale is 30. love.physics.setMeter does not apply retroactively to created objects. Created objects retain their meter coordinates but the scale factor will affect their pixel coordinates.
	world = love.physics.newWorld(0, 18.81*32, true) --The world the everything exists in. Horizontal gravity=0. Bertical gravity=9.81. True says that the world is allowed to sleep.
	
	objects = {} -- table to hold all our physical objects

	--a list to store our lines
	objects.lines = {}
	
	--let's create a ball
	objects.ball = {}
	objects.ball.x = 1550
	objects.ball.y = 50
	objects.ball.radius = 20
	objects.ball.body = love.physics.newBody(world, objects.ball.x, objects.ball.y, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
	objects.ball.shape = love.physics.newCircleShape(objects.ball.radius) --the ball's shape has a radius of 20
	objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1) -- Attach fixture to body and give it a density of 1.
	objects.ball.fixture:setRestitution(0.9) --let the ball bounce

	objects.block1 = {}
	objects.block1.x = 100
	objects.block1.y = 825
	objects.block1.height = 100
	objects.block1.width = 40
	objects.block1.body = love.physics.newBody(world, objects.block1.x, objects.block1.y, "static")
	objects.block1.shape = love.physics.newRectangleShape(objects.block1.width, objects.block1.height)
	objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 1) -- A higher density gives it more mass.

	objects.block2 = {}
	objects.block2.x = 250
	objects.block2.y = 825
	objects.block2.height = 100
	objects.block2.width = 40
	objects.block2.body = love.physics.newBody(world, objects.block2.x, objects.block2.y, "static")
	objects.block2.shape = love.physics.newRectangleShape(objects.block2.width, objects.block2.height)
	objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 1) -- A higher density gives it more mass.
	
	objects.block2 = {}
	objects.block2.x = 250
	objects.block2.y = 825
	objects.block2.height = 100
	objects.block2.width = 40
	objects.block2.body = love.physics.newBody(world, objects.block2.x, objects.block2.y, "static")
	objects.block2.shape = love.physics.newRectangleShape(objects.block2.width, objects.block2.height)
	objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 1) -- A higher density gives it more mass.
	
	objects.block3 = {}
	objects.block3.x = 175
	objects.block3.y = 850
	objects.block3.height = 40
	objects.block3.width = 120
	objects.block3.body = love.physics.newBody(world, objects.block3.x, objects.block3.y, "static")
	objects.block3.shape = love.physics.newRectangleShape(objects.block3.width, objects.block3.height)
	objects.block3.fixture = love.physics.newFixture(objects.block3.body, objects.block3.shape, 1) -- A higher density gives it more mass.
	
	--initial graphics setup
	love.graphics.setBackgroundColor(0.41, 0.53, 0.97) --set the background color to a nice blue
	love.window.setMode(1600, 900) --set the window dimensions to 650 by 650
end
 
function love.update(dt)
	if not pause then
		world:update(dt) --this puts the world into motion
	end
		
	
---------------------------------------------------------------------------------------------------------------------------	
--This is an example of what you are trying to draw
	line = {}
	line.x1 = 1575
	line.x2 = 1525
	line.y1 = 100
	line.y2 = 100
	line.body = love.physics.newBody(world, 0, 0, "static")
	line.shape = love.physics.newEdgeShape(line.x2, line.y2, line.x1, line.y1)
	line.fixture = love.physics.newFixture(line.body, line.shape, 5)
	table.insert(objects.lines,line)
-----------------------------------------------------------------------------------------------------------------------------


	
	--draw lines when the mouse is down
	if love.mouse.isDown(1) then

	
	
-----------------------------------------------------------------------------------------------------------------------------
		drawn_x = love.mouse.getX()	--This function gets the x coordinate that the mouse is on
		--[CODE LINE] Do the same thing with the y coordinate
		drawn_y = love.mouse.getY()	--This function gets the y coordinate that the mouse is on
-----------------------------------------------------------------------------------------------------------------------------


		
		if oldx then	--Here we check if oldx exists. We do this to see if there is a second x and y coordinate that our line can originate from.
			line = {}
			--The lines x coordinates are coded for you
			line.x1 = drawn_x
			line.x2 = oldx

			
-----------------------------------------------------------------------------------------
			-- [CODE LINE] Do the same thing for the y coordinate
			line.y1 = drawn_y
			line.y2 = oldy
-----------------------------------------------------------------------------------------


			
--------------------------------------------------------------------------------------------------------------------------------------			
			-- Put the line into the world, this is done the same way that you did this in the ball and rectangle game
			--[CODE LINE] Code a line for a new Body
			line.body = love.physics.newBody(world, 0, 0, "static")
			--[CODE LINE] Code a line for a new shape. you will need to use the funtion love.physics.newEdgeShape(x1, y1, x2, y2)
			line.shape = love.physics.newEdgeShape(drawn_x, drawn_y, oldx, oldy)
			--[CODE LINE] Fix the body and shape together, 
			line.fixture = love.physics.newFixture(line.body, line.shape, 1, "static")
			--[CODE LINE] insert this line into our lines table, the same way that we did it on line 59
			table.insert(objects.lines, line) 
---------------------------------------------------------------------------------------------------------------------------------------


		--else
		--	oldx = nil
		--	oldy = nil
		end

		
---------------------------------------------------------------------------------------------------------------------------------------------------------------		
		-- We want the line to be continuous, meaning we want the last location that our mouse recorded to be connected to the next location our mouse records
		-- Because of this we want to set our variable oldx and oldy to our most recently recorded x and y variables
		oldx = drawn_x
		oldy = drawn_y
---------------------------------------------------------------------------------------------------------------------------------------------------------------	
	
	else
		-- We set these values to nothing because otherwise the lines that we draw would be connected to the previous line we drew
		-- Try commenting it out and see what happens
		oldx = nil
		oldy = nil
	end
  
end

function love.keypressed(button)
	if button == "space" then
		pause = not pause
	elseif button == "r" then
		objects.ball.body:setPosition(1450, 50)
		objects.ball.body:setLinearVelocity(0, 0)
	end
end
 
 
function love.draw()

	love.graphics.print(love.timer.getFPS().."\nSpace to play/pause")	-- Prints some text on the display screen
 
	love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())	-- prints the image of the ball on the screen
	
	love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
	love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
	love.graphics.polygon("fill", objects.block3.body:getWorldPoints(objects.block3.shape:getPoints()))
	
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--Check the code for the quidditch game and see how multiple hoops we draw in a loop. Make a similar loop for objects.lines instead of objects.hoops
	for _, line in pairs(objects.lines) do	--loop through every line we've created
	--Within the loop you will want to draw a line. The syntax is love.graphics.line(x1, y1, x2, y2)
		love.graphics.line( line.x1, line.y1, line.x2, line.y2)	-- And draw each line on the screen, the line has a start and end location so you need to give the start and end of each line 
	end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
end