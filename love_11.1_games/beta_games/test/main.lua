function love.load()

	--love.physics.setMeter(64) --the height of a meter our worlds will be 64px
	--Sets the pixels to meter scale factor, All coordinates in the physics module are divided by this number and converted to meters, and it creates a convenient way to draw the objects directly to the screen without the need for graphics transformations. It is recommended to create shapes no larger than 10 times the scale. This is important because Box2D is tuned to work well with shape sizes from 0.1 to 10 meters. The default meter scale is 30. love.physics.setMeter does not apply retroactively to created objects. Created objects retain their meter coordinates but the scale factor will affect their pixel coordinates.
	world = love.physics.newWorld(0, 9.81*64, true)
	
	--let's create a ball
	ball = {}
	ball.body = love.physics.newBody(world, 650/2, 0, "dynamic") --Determines where the object will start. In the center of the world and dynamic(moves around)
	ball.shape = love.physics.newCircleShape(20) --the ball's shape has a radius of 20
	ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1) -- Attach fixture to body and give it a density of 1.
	ball.fixture:setRestitution(0.9) --let the ball bounce
	
	line = {}
	line.x1 = 0
	line.x2 = 650
	line.y1 = 300
	line.y2 = 300
	print("("..line.x1..", "..line.y1.."), ("..line.x2..", "..line.y2..")")
	line.body = love.physics.newBody(world, 0, 0, "static")
	line.shape = love.physics.newEdgeShape(line.x1, line.y1, line.x2, line.y2)
	line.fixture = love.physics.newFixture(line.body, line.shape, 5)
	
end

function love.update(dt)
	world:update(dt)
end

function love.draw()
	love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
	love.graphics.line(line.shape:getPoints())
end