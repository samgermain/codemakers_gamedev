function erase()
	--If the right mouse button is down
		--Save the x and y coordinates of the mouse, remember to consider the camera
		index = 1	--A counter that stores the current index in objects.lines
		--For each line do
			-- If the eraser x and y coordinates cross over a line segment then
				-- table.remove(objects.lines, index)
				-- set the line body type to be dynamic, this way the line will fall
			-- end if statement
			index = index + 1	--Increase the counter by 1, so it always points to the current line
		--end for loop end
	--end if statment
end