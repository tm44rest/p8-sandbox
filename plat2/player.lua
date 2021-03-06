player = new_type(1)
function player:init()
  -- player pos is center-right(?) on ground
  self.x += 4
  self.y += 8
  -- hitbox is relative to x and y
  self.hit_x = -3
  self.hit_y = -7
  self.hit_w = 6
  self.hit_h = 7
end
function player:update()
  local on_ground = self:check_solid(0,1)

  -- facing
  if input_x ~= 0 then
    self.facing = input_x
  end

  -- running
  local target, accel = 0, 0.1
  if abs(self.vel_x) > 2 and input_x == sgn(self.vel_x) then
    target,accel = 1, 0.05
  elseif on_ground then
    target, accel = 1, 0.4
  elseif input_x != 0 then
    target, accel = 1, 0.2
  end
  self.vel_x = approach(self.vel_x, input_x * target, accel)

  -- gravity
  if not on_ground then
    if self:check_solid(0,-1) then
      -- head hit ceiling
      -- fun idea: if set to 0, she clings to ceiling. what if thats a game mechanic?
      self.vel_y = approach(self.vel_y, 2.5, .4)
    else
      self.vel_y = min(self.vel_y + .15, 2.5)
    end
  else
    self.vel_y = 0
  end

  -- jump
  if input_jump_pressed > 0 then
    if on_ground then
      input_jump_pressed = 0
      on_ground = false
      self.vel_y = -3
    end
  end


  -- apply velocity
  self:move_x(self.vel_x)
  self:move_y(self.vel_y)

  -- sprite
  if not on_ground then
    self.spr = 3    
  elseif input_x != 0 then
    self.spr += .125
    if self.spr >=3 then self.spr = 1 end --can you do this with modulo?
  else
    self.spr = 1
  end

end
function player:draw ()
	spr(self.spr, self.x  - 4, self.y - 8, 1, 1, self.facing != 1)
  print(self.vel_y)
end