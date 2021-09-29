-- refs:

-- default values
_button = {}
function _button:press()
  sfx(0)
end
function _button:draw()
  print(self.str,self.x+4,self.y+2,7)
  rect(self.x,self.y,self.x+self.w,self.y+self.h,7)
end
function _button:selected_draw()
  print(self.str,self.x+4,self.y+2,10)
  rect(self.x,self.y,self.x+self.w,self.y+self.h,10)
end

-- constructor
function create_button(str,x,y,w,h,p,d,s)
  local btn = { 
    __index = _button,
    str=str,
    x=x,
    y=y,
    w=w,
    h=h
  }
  if p then btn.press = p end
  if d then btn.draw = d end
  if s then btn.selected_draw = s end
  setmetatable(btn,btn)
  return btn
end