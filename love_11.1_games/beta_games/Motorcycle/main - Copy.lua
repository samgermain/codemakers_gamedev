require("Camera")
function love.load()
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
 
  objects = {} -- table to hold all our physical objects
 
  --let's create the ground
  objects.ground = {}
  groundPiece = {}
  groundPiece.x = 1700/2
  groundPiece.y = 1000-50/2
  groundPiece.width = 1700
  groundPiece.height = 50
  groundPiece.body = love.physics.newBody(world, groundPiece.x, 1000-50/2, "static") --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (1700/2, 1000-50/2)
  groundPiece.shape = love.physics.newRectangleShape(groundPiece.width, groundPiece.height) --make a rectangle with a width of 1700 and a height of 50
  groundPiece.fixture = love.physics.newFixture(groundPiece.body, groundPiece.shape, 1); --attach shape to body, give it a density of 1. 
  
  table.insert(objects.ground, groundPiece)
  
   --let's create a ball
  objects.motor = {}
  objects.motor.x = 1700/2
  objects.motor.y = 1000/2
  objects.motor.width = 100
  objects.motor.height = 50
  
  objects.motor.body = love.physics.newBody(world, objects.motor.x, objects.motor.y, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  objects.motor.shape = love.physics.newRectangleShape(objects.motor.width, objects.motor.height) --the ball's shape has a radius of 20
  objects.motor.fixture = love.physics.newFixture(objects.motor.body, objects.motor.shape, 1) -- Attach fixture to body and give it a density of 1.
  objects.motor.img = love.graphics.newImage('images/motorcycle.png')
  
  --initial graphics setup
  love.graphics.setBackgroundColor(0.41, 0.53, 0.97) --set the background color to a nice blue
  love.window.setMode(1700, 1000) --set the window dimensions to 650 by 650
end
 
 
function love.update(dt)
  world:update(dt) --this puts the world into motion
  Camera.update(dt)
end
 
function love.draw()
  love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
  for _, block in pairs(objects.ground) do
	love.graphics.rectangle("fill", block.body:getX() - Camera.x, block.body:getY() - Camera.y, 0, 0, block.width, block.height) --:getWorldPoints(block.shape:getPoints()))
  end
  
  --love.graphics.setColor(0.76, 0.18, 0.05) --set the drawing color to red for the ball
  --love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())
  love.graphics.draw(objects.motor.img, objects.motor.body:getX(), objects.motor.body:getY()-(objects.motor.height/objects.motor.img:getHeight())/2, 0, objects.motor.height/objects.motor.img:getHeight())
 
end