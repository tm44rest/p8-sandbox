pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- oop3
-- celeste 2 style, modified.
-- great for platformers
-- or anything else that doesnt
-- need extensive hierarchies,
-- just default functions for
-- objects (which is the real
-- advantage of oop)
types={}
objects={}

-- base type
object = {}
function object:update () end
function object:draw ()
	spr(self.spr,self.x,self.y)
end
function object:example()
	print("goodbye")
end
function object:c()
	print("hello, i am object " .. self.id)
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


-- orb is an object type
orb = new_type(2)
function orb:example ()
	-- example of overwriting method
	print("hello")
end
function orb:init ()
	print("initializing myself :)")
end

-- meme is an object of type orb
meme = create(orb,60,70)

meme:draw()
meme:example()
meme:c()
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000088880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000088880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
