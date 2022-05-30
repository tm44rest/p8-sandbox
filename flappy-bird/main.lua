function _init()
  t = 0
  bird_x = 15 -- constant
  bird_y = 40
  vel_y = 0
  acc_y = .25
  term_vel = 4.5
  jump_vel = -2.5
  held = false
  clicked = false
  wing_spr = 3
  wing_cutoff = 1
  wall_width = 20
  wall_gap = 34
  wall_start = 140
  ceiling_width = 8
  floor_width = 8

  walls = {}

  add_wall(30)

  _upd = upd_game
end

function upd_game()
  t = (t + 1) % 50

  -- input
  if btn(4) then
    if held then clicked = false 
    else clicked = true end
    held = true
  else
    held = false
    clicked = false
  end

  -- jump
  if clicked then
    vel_y = jump_vel
  else
    vel_y += acc_y
    if vel_y > term_vel then vel_y = term_vel end
  end
  bird_y += vel_y

  -- walls
  for w in all(walls) do
    if w.x < -wall_gap then del(walls, w)
    else w.x -= 2 end
  end
  if t == 0 then
    add_wall(flr(rnd(60)+20))
  end

  -- check collision
  if bird_y <= ceiling_width+1 or bird_y+6 >= 128-floor_width or hit_wall() then 
    _upd = upd_gameover
  end
end

function upd_gameover()

end

function _update()
  _upd()
end

function _draw()
  cls()

  -- bird
  spr(1,bird_x,bird_y)
  if vel_y > wing_cutoff then wing_spr = 4
  elseif vel_y <= wing_cutoff and vel_y >= -wing_cutoff then wing_spr = 3
  else wing_spr = 2
  end
  spr(wing_spr,14,bird_y)

  -- walls
  for w in all(walls) do
    rectfill(w.x,0,w.x+wall_width,w.y,11)
    rectfill(w.x,w.y+wall_gap,w.x+wall_width,128,11)
  end

  rectfill(0,0,128,ceiling_width,11)
  rectfill(0,128-floor_width,128,128,11)
end

function add_wall(y)
  -- adds a wall at wall_start with gap starting at y
  add(walls, {x=wall_start,y=y})
end

function hit_wall()
  for w in all(walls) do
    if (w.x <= bird_x+7 and bird_x <= w.x+wall_width) and
      not (w.y <= bird_y and bird_y+7 <= w.y + wall_gap) then
      return true
    end
  end
  return false
end

function game_over()
  
  _init()
end