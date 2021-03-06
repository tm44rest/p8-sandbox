types={}
objects={}

-- base type
object = {}
object.vel_x = 0
object.vel_y = 0
object.acc_x = 0
object.acc_y = 0
object.remainder_x = 0
object.remainder_y = 0
object.facing = 1
-- hitbox
object.hit_x = 0
object.hit_y = 0
object.hit_w = 8
object.hit_h = 8
function object:check_solid(ox,oy)
	ox = ox or 0
	oy = oy or 0

	for i = flr((ox + self.x + self.hit_x)/8),
					flr((ox + self.x + self.hit_x + self.hit_w - 1) / 8) do
		for j = flr((oy + self.y + self.hit_y)/8), 
						flr((oy + self.y + self.hit_y + self.hit_h - 1) / 8) do
			if fget(mget(i, j), 0) then 
				return true
			end
		end
	end

	-- optional: check solid objects? if applicable

	return false
end
function object:move_x(dx)
	-- round to integer and remember remainder
	self.remainder_x += dx
	local mx = flr(self.remainder_x + 0.5)
	self.remainder_x -= mx

	local mxs = sgn(mx)
	while mx != 0 do
		if self:check_solid(mxs, 0) then
			return
		else
			self.x += mxs
			mx -= mxs
		end
	end
end
function object:move_y(dy)
	self.remainder_y += dy
	local my = flr(self.remainder_y + 0.5)
	self.remainder_y -= my

	local mys = sgn(my)
	while my != 0 do
		if self:check_solid(0, mys) then
			return
		else
			self.y += mys
			my -= mys
		end
	end
end
function object:update () end
function object:draw ()
	spr(self.spr,self.x,self.y)
end

function create(type,x,y)
	local obj = {__index=type,
		x = x,
		y = y,
		id = x..","..y
		}
	setmetatable(obj, obj)
	add(objects, obj)
	if obj.init then obj:init() end
	return obj
end

function new_type(spr)
	local obj = {
	__index=object,
	spr = spr,
	base = object }
	setmetatable(obj, obj)
	types[spr] = obj
	return obj
end