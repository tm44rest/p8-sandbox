-- refs: menu, button

function _init()
  ---------------
  -- example 1 --
  ---------------

  -- is this generic enough to add a general version to menu.lua? 
  -- don't think so yet, need to see use cases of menus/buttons first
  m1 = create_menu("m1",3,4)
  t1 = {}
  for i=1,3 do
    t1[i]={}
    for j=1,4 do
      t1[i][j]=0
    end
  end
  local p1 = function (self)
    t1[self.col][self.row] += 1
  end
  local d1 = function (self)
    _button.draw(self)
    print(t1[self.col][self.row],self.x+2,self.y+2,6)
  end
  local s1 = function (self)
    _button.selected_draw(self)
    print(t1[self.col][self.row],self.x+2,self.y+2,15)
  end
  for i=1,3 do
    for j=1,4 do
      m1:add(create_button(8+(i-1)*16,20+(j-1)*8,16,8,p1,d1,s1),i,j) -- this is just plain ugly...
    end
  end


  m2 = create_menu("m2",4,2)
  t2 = {}
  for i=1,4 do
    t2[i]={}
    t2[i][1] = 0
    t2[i][2] = 0
  end
  local p2 = function (self)
    t2[self.col][self.row] += 1
  end
  local d2 = function (self)
    _button.draw(self)
    print(t2[self.col][self.row],self.x+2,self.y+2,6)
  end
  local s2 = function (self)
    _button.selected_draw(self)
    print(t2[self.col][self.row],self.x+2,self.y+2,15)
  end 
  m2:add(create_button(8,20,16,8,p2,d2,s2),1,1)
  m2:add(create_button(8+16,20,16,8,p2,d2,s2),2,1)
  m2:add(create_button(8+32,20,16,8,p2,d2,s2),3,1)
  m2:add(create_button(8+48,20,16,8,p2,d2,s2),4,1)
  m2:add(create_button(8,20+8,16,8,p2,d2,s2),1,2)
  -- m2:add(create_button(4,2,8+48,20+8,16,8,p2,d2,s2),4,2)


  m3 = create_menu("m2",2,4)
  t3 = {}
  for i=1,2 do
    t3[i]={}
    t3[i][1] = 0
    t3[i][2] = 0
    t3[i][3] = 0
    t3[i][4] = 0
  end
  local p3 = function (self)
    t3[self.col][self.row] += 1
  end
  local d3 = function (self)
    _button.draw(self)
    print(t3[self.col][self.row],self.x+2,self.y+2,6)
  end
  local s3 = function (self)
    _button.selected_draw(self)
    print(t3[self.col][self.row],self.x+2,self.y+2,15)
  end 
  m3:add(create_button(8,20,16,8,p3,d3,s3),1,1)
  m3:add(create_button(8+16,20,16,8,p3,d3,s3),2,1)
  m3:add(create_button(8,20+8,16,8,p3,d3,s3),1,2)
  m3:add(create_button(8,20+16,16,8,p3,d3,s3),1,3)
  m3:add(create_button(8,20+24,16,8,p3,d3,s3),1,4)
  m3:add(create_button(8+16,20+24,16,8,p3,d3,s3),2,4)

  m = m3
end

function _update()
  m:update()
end

function _draw()
  cls()
  m:draw()
end