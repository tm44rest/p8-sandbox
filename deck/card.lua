-- refs:

_card = {}
function _card:effect()
  sfx(0)
end
function _card:print_name(x,y)
  print(self.n,x,y,7)
end

function create_card(n)
  local crd = {
    __index = _card,
    n = n
  }
  setmetatable(crd,crd)
  return crd
end