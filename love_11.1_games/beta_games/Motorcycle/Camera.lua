Camera = {
	x = 0,
	y = 0
}

function Camera:update(dt)

	if love.keyboard.isDown("right") then --RIGHT ARROW BUTTON IS DOWN then
		self.x = self.x + 5
	elseif love.keyboard.isDown("left") then
		self.x = self.x - 5
	end
		
	if love.keyboard.isDown("up") then
		self.y = self.y - 5
	elseif love.keyboard.isDown("down") then
		self.y = self.y + 5
	end

end

function Camera:follow(dt, body)

	Camera.x = body:getX() - love.graphics.getWidth()/2
	--Camera.y = body:getY() - love.graphics.getHeight()/2

end


