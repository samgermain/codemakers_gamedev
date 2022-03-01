Camera = {
	x = 0,
	y = 0
}

function Camera.update(dt)

	if love.keyboard.isDown("right") then --RIGHT ARROW BUTTON IS DOWN then
		Camera.x = Camera.x + 5
	elseif love.keyboard.isDown("left") then
		Camera.x = Camera.x - 5
	end
		
	if love.keyboard.isDown("up") then
		Camera.y = Camera.y - 5
	elseif love.keyboard.isDown("down") then
		Camera.y = Camera.y + 5
	end

end

function Camera:follow(dt, wizard)

	Camera.x = wizard.body:getX() - love.graphics.getWidth()/2
	Camera.y = wizard.body:getY() - love.graphics.getHeight()/2

end
