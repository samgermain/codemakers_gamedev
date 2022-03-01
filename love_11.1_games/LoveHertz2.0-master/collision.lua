function simpleCollision(o1, o2)
  if o1 ~= nil and o2 ~= nil then
    return o1.x < o2.x+o2.width and
           o2.x < o1.x+o1.width and
           o1.y < o2.y+o2.height and
           o2.y < o1.y+o1.height
  else
    return false
  end
end

function pointInObject(x, y, o)
  if o ~= nil then
    return x < o.x+o.width and
           x > o.x and
           y < o.y+o.height and
           y > o.y
  else
    return false
  end
end

function collision( ent, dt )
  
  ent.grounded = false
  ent.rightCol = false
  ent.leftCol = false
  ent.upCol = false
  
  local count = 1
	while count <= table.getn(objects) do
    
    if ent.xSpeed > 0 and ent.x + ent.width + ent.xSpeed*dt > objects[count].x then
      if ent.y+ent.height > objects[count].y and ent.y < objects[count].y + objects[count].height then
        if ent.x < objects[count].x + objects[count].width/2 then
          ent.x = objects[count].x - ent.width
          ent.xSpeed = 0
          ent.rightCol = true
        end
      end
		end
    
    if ent.xSpeed < 0 and ent.x + ent.xSpeed*dt < objects[count].x + objects[count].width then
      if ent.y+ent.height > objects[count].y and ent.y < objects[count].y + objects[count].height then
        if ent.x >= objects[count].x + objects[count].width/2 then
          ent.x = objects[count].x + objects[count].width
          ent.xSpeed = 0
          ent.leftCol = true
        end
      end
		end
    
    if ent.ySpeed > 0 and ent.y + ent.height + ent.ySpeed*dt+2 > objects[count].y then
      if ent.x+ent.width > objects[count].x and ent.x < objects[count].x + objects[count].width then
        if ent.y + ent.height < objects[count].y + objects[count].height/2 then
          ent.y = objects[count].y - ent.height
          ent.ySpeed = 0
          ent.grounded = true
        end
      end
		end
    
    if ent.ySpeed < 0 and ent.y + ent.ySpeed*dt < objects[count].y + objects[count].height then
      if ent.x+ent.width > objects[count].x and ent.x < objects[count].x + objects[count].width then
        if ent.y > objects[count].y + objects[count].height/2 then
          ent.y = objects[count].y + objects[count].height
          ent.ySpeed = 0
          ent.upCol = true
        end
      end
		end
    count = count + 1
	end
end


function cameraCollision( player, dt )
  
  player.grounded = false
  player.rightCol = false
  player.leftCol = false
  player.upCol = false
  
  local count = 1
	while count <= table.getn(cameraColliders) do
    
    if player.xSpeed > 0 and player.x + player.width + player.xSpeed*dt > cameraColliders[count].x then
      if player.y+player.height > cameraColliders[count].y and player.y < cameraColliders[count].y + cameraColliders[count].height then
        if player.x < cameraColliders[count].x + cameraColliders[count].width/2 then
          player.x = cameraColliders[count].x - player.width
          player.xSpeed = 0
          player.rightCol = true
        end
      end
		end
    
    if player.xSpeed < 0 and player.x + player.xSpeed*dt < cameraColliders[count].x + cameraColliders[count].width then
      if player.y+player.height > cameraColliders[count].y and player.y < cameraColliders[count].y + cameraColliders[count].height then
        if player.x >= cameraColliders[count].x + cameraColliders[count].width/2 then
          player.x = cameraColliders[count].x + cameraColliders[count].width
          player.xSpeed = 0
          player.leftCol = true
        end
      end
		end
    
    if player.ySpeed > 0 and player.y + player.height + player.ySpeed*dt > cameraColliders[count].y then
      if player.x+player.width > cameraColliders[count].x and player.x < cameraColliders[count].x + cameraColliders[count].width then
        if player.y + player.height < cameraColliders[count].y + cameraColliders[count].height/2 then
          player.y = cameraColliders[count].y - player.height
          player.ySpeed = 0
          player.grounded = true
          player.jumped = false
        end
      end
		end
    
    if player.ySpeed < 0 and player.y + player.ySpeed*dt < cameraColliders[count].y + cameraColliders[count].height then
      if player.x+player.width > cameraColliders[count].x and player.x < cameraColliders[count].x + cameraColliders[count].width then
        if player.y > cameraColliders[count].y + cameraColliders[count].height/2 then
          player.y = cameraColliders[count].y + cameraColliders[count].height
          player.ySpeed = 0
          player.upCol = true
        end
      end
		end
    count = count + 1
	end
end