-- refs: button

-- default values
_menu = {}
function _menu:add(btn,col,row)
  assert(col>0 and col <= self.width)
  assert(row>0 and row <= self.height)
  btn.col=col
  btn.row=row
  self.buttons[col][row]=btn
end
function _menu:draw()
  for i,t in pairs(self.buttons) do
    for j,b in pairs(t) do
      b:draw()
    end
  end
  -- print("self.selected.col: " .. self.selected.col,0,0)
  -- print("self.selected.row: " .. self.selected.row,0,6)
  self.buttons[self.selected.col][self.selected.row]:selected_draw()
end
function _menu:move(dir)
  local dirx = {-1, 1, 0, 0}
  local diry = {0, 0, -1, 1}
  local i = self.selected.col + dirx[dir+1]
  local j = self.selected.row + diry[dir+1]
  
  local in_bounds = (dir == 0 and i >= 1) or
                    (dir == 1 and i <= self.width) or
                    (dir == 2 and j >= 1) or
                    (dir == 3 and j <= self.height)
  if in_bounds then
    local b = self.buttons[i][j]
    local diff_i = abs(diry[dir+1])
    local diff_j = abs(dirx[dir+1])
    
    -- closest up/left. if none, closest down/right
    while b == nil and i > 1 and j > 1 do
      i -= diff_i
      j -= diff_j
      b = self.buttons[i][j]
    end
    while b == nil and i < self.width and j < self.height do
      i += diff_i
      j += diff_j
      b = self.buttons[i][j]
    end

    if b then
      self.selected.col = i
      self.selected.row = j
    end
  end
end
function _menu:update()
  if     btnp(0) then self:move(0)
  elseif btnp(1) then self:move(1)
  elseif btnp(2) then self:move(2)
  elseif btnp(3) then self:move(3)
  end
  if btnp(4) then self.buttons[self.selected.col][self.selected.row]:press()
  end
end
function _menu:remove(x,y)
  self.buttons[x][y]=nil
end

-- constructor for an n-by-m menu
function create_menu(n,m)
  local mnu = {
    __index = _menu,
    buttons = {},
    width=n,
    height=m,  
    selected={col=1,row=1}
  }
  -- have to initialize every column of a 2d table in lua
  for i=1,n do
    mnu.buttons[i]={}
  end
  setmetatable(mnu,mnu)
  return mnu
end