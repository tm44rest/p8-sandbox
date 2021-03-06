function _init()
  -- black is opaque, light-blue
  -- is transparent
  palt(0,false)
  palt(12,true)

  for i=0,64 do
    for j=0,64 do
      local tile = mget(i,j)
      if fget(tile,7) then
        create(types[tile],i*8,j*8)
      end
    end
  end
end

function _update60()
  update_input()

  for o in all(objects) do
    o:update()
  end
end

function _draw()
  cls(12)
  
  -- draw tileset
  map(0,0,0,0,64,64,1)

  
  -- draw objects
	local p = nil
	for o in all(objects) do
		if o.__index == player then p = o else o:draw() end
	end
	if p then p:draw() end

  print(p.x)
  print(p.y)
end

function approach(x, target, max_delta)
	return x < target and min(x + max_delta, target) or max(x - max_delta, target)
end