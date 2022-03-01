require("Camera")

function love.load()
  printx = 0	--position to be drawn on when the mouse is pressed
  printy = 0	--position to be drawn on when the mouse is pressed
  oldx = 0
  oldy = 0
  lineStart = 0
  pause = true

  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
	--Sets the pixels to meter scale factor, All coordinates in the physics module are divided by this number and converted to meters, and it creates a convenient way to draw the objects directly to the screen without the need for graphics transformations. It is recommended to create shapes no larger than 10 times the scale. This is important because Box2D is tuned to work well with shape sizes from 0.1 to 10 meters. The default meter scale is 30. love.physics.setMeter does not apply retroactively to created objects. Created objects retain their meter coordinates but the scale factor will affect their pixel coordinates.
  world = love.physics.newWorld(0, 9.81*64, true) --The world the everything exists in. Horizontal gravity=0. Bertical gravity=9.81. True says that the world is allowed to sleep.
	
  objects = {} -- table to hold all our physical objects
 
  --let's create the ground
  objects.lineConnects = {}
  objects.lines = {}
  --objects.ground = {}
  --objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2) 
	-- Anchors to the center so (650/2, 650-50/2)
	-- love.physics.newBody( world, x, y, type ).
		-- world: the world to create the body in
		-- x: the x position of the body
		-- y: the y position of the body
		-- type: the type of the body.
			-- static: doesn't move
			-- dynamic: moves
  --objects.ground.shape = love.physics.newRectangleShape(650, 50) --make a rectangle with a width of 650 and a height of 50
  --objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape); --attach shape to body
 
  --let's create a ball
  objects.ball = {}
  objects.ball.body = love.physics.newBody(world, 650/2, 0, "dynamic") --Determines where the object will start. In the center of the world and dynamic(moves around)
  objects.ball.shape = love.physics.newCircleShape(20) --the ball's shape has a radius of 20
  objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1) -- Attach fixture to body and give it a density of 1.
  objects.ball.fixture:setRestitution(0) --let the ball bounce
  objects.ball.body:setBullet(true)
 
 
  --objects.block2 = {}
  --objects.block2.body = love.physics.newBody(world, 200, 400, "dynamic")
  --objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
  --objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)
 
  --initial graphics setup
  love.graphics.setBackgroundColor(0.41, 0.53, 0.97) --set the background color to a nice blue
  love.window.setMode(650, 650) --set the window dimensions to 650 by 650
end
 
 
function love.update(dt)
  if not pause then
	world:update(dt) --this puts the world into motion
  end
  Camera.update(dt)
  
  if not love.mouse.isDown(1) then
	oldx = nil
	oldy = nil
  end
  
 
  --draw lines when the mouse is down
  if love.mouse.isDown(1) then
	local printx = love.mouse.getX() + Camera.x	--x coordinate of the mouse
	local printy = love.mouse.getY() + Camera.y	--y coordinate of the mouse
	--line = {}
	--line.body = love.physics.newBody(world, printx, printy, "static")	--assign the created dot of the line to the game world, with the x and y coordinates of the mouse. Static because it does not move
	--line.shape = love.physics.newRectangleShape(0, 0, 5, 5)		--The newly created object will be a 5x5 rectangle
	--line.fixture = love.physics.newFixture(line.body, line.shape, 5) --Fixes the object to the world, otherwise the line-rider would just fall through it. Density is 5.
	--table.insert(objects.lineConnects, line)	--We keep a table of all the line parts we have. We can then draw and manipulate them later
--	love.graphics.setColor(50,50,50)	--Set the line fragment to be grey
--	love.graphics.polygon("fill", line.body:getWorldPoints(line.shape:getPoints()))

	if oldx ~= nil then
		line = {}
		line.x1 = oldx
		line.x2 = printx
		line.y1 = oldy
		line.y2 = printy
		print("("..line.x1..", "..line.y1.."), ("..line.x2..", "..line.y2..")")
		line.body = love.physics.newBody(world, 0, 0, "static")
		line.shape = love.physics.newEdgeShape(printx, printy, oldx, oldy)
		line.fixture = love.physics.newFixture(line.body, line.shape, 5)
		table.insert(objects.lines, line) 
	end
	
	oldx = printx
	oldy = printy
	
  end
  
end

function love.keypressed(button)
	if button == "space" then
		pause = not pause
	end
end
 
 
function love.draw()

	love.graphics.print(love.timer.getFPS().."\nSpace to play/pause")

  --love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
  --love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
 
  love.graphics.setColor(0.76, 0.18, 0.05) --set the drawing color to red for the ball
  love.graphics.circle("fill", objects.ball.body:getX() - Camera.x, objects.ball.body:getY() - Camera.y, objects.ball.shape:getRadius())
 
--  love.graphics.setColor(0.20, 0.20, 0.20) -- set the drawing color to grey for the blocks
--  love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
  
  for _, block in pairs(objects.lineConnects) do
	love.graphics.rectangle("fill", block.body:getX() - Camera.x, block.body:getY() - Camera.y, 0, 0, 5, 5) --:getWorldPoints(block.shape:getPoints()))
  end
	
  for _, line in pairs(objects.lines) do
	--print("swag")
	love.graphics.line( line.x1 - Camera.x, line.y1 - Camera.y, line.x2 - Camera.x, line.y2 - Camera.y) --:getWorldPoints(block.shape:getPoints()))
  end
	
end