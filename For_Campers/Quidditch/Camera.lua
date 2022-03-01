
-- We are going to create an object named Camera here, it will have an x and y coordinate
Camera = {
	x = 0,
	y = 0
}

--This is the function that is called when the game is paused
function Camera.update(dt)

	if love.keyboard.isDown("left") then --RIGHT ARROW BUTTON IS DOWN then
		Camera.x = Camera.x - 5
	--elseif --The Right arrow button is down
		-- Then move the Camera the oppossite way
	end
		
	if love.keyboard.isDown("up") then
		Camera.y = Camera.y - 5
	--elseif -- The down arrow key is being held
		--Then move the camera down
	end

end

--This is the function that is called when the game is not paused
function Camera:follow(dt, wizard)

------------------------------------------------------------------------------------------------------------------------
	--This sets the Camera position to follow the wizard in the horizontal direction
	Camera.x = wizard.body:getX() - love.graphics.getWidth()/2 --The subtraction is done so that the camera is centered on the wizard, instead of the wizard being at the side of the screen
	--Try doing the same thing with the vertical direction
------------------------------------------------------------------------------------------------------------------------

end
