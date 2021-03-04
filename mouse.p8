pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- mouse controls test
-- by rest

function _init()
	init_mouse(0)
	init_mouse_listeners()
	create_mouse_listener(
		"test",
		60,
		60,
		8,
		8,
		(function() rectfill(60,60,68,68,8) end)
	)
	create_mouse_listener(
		"test2",
		80,
		80,
		8,
		8,
		(function() rectfill(80,80,88,88,12) end)
	)
end

function _update60()
	update_mouse()
	update_mouse_listeners()
end

function _draw()
	cls()
	draw_mouse_listeners()
	draw_mouse()
	
	--debug
	--l1=listeners.test
	--print(l1.hovered)
	--print(l1.held)
	--print(l1.clicked)
end
-->8
-- mouse controls

-- initializes the mouse
-- with sprite s
function init_mouse(s)
	poke(0x5f2d,0x1)
	mouse_x=0
	mouse_y=0
	mouse_button=0
	mouse_released=0 --active 1f
	mouse_spr=s
end

-- updates mouse globals
function update_mouse()
	mouse_x=stat(32)-1
	mouse_y=stat(33)-1
	local temp=mouse_button
	mouse_button=stat(34)
	if mouse_button==0 and temp!=0
	then
		mouse_released=temp
	else
		mouse_released=0
	end
end

-- draws the mouse
function draw_mouse()
	spr(mouse_spr,mouse_x,mouse_y)
	
	-- debug
	print("("..mouse_x..","..mouse_y..")",7)
	print(mouse_button)
	print(mouse_released)
end
-->8
-- mouse listeners
-- i.e. stuff you click on
-- (only rectangles for now)

function init_mouse_listeners()
	listeners={}
end

function create_mouse_listener(name,x,y,h,w,drw,hov_drw,held_drw)
	hov_drw = hov_drw  or drw
	held_drw= held_drw or drw
	listeners[name]={
			x=x,
			y=y,
			w=w,
			h=h,
			drw=drw,
			hov_drw=hov_drw,
			held_drw=held_drw,
			hovered=false,
			held=false,
			clicked=false
		}
	
end

function update_mouse_listeners()
		for n,b in pairs(listeners) do
			if mouse_x>=b.x and mouse_x<=b.x+b.w
			and mouse_y>=b.y and mouse_y<=b.y+b.h
			then
				b.hovered=true
				if mouse_button==1 then
					b.held=true
					b.clicked=false
				elseif mouse_released==1 then
					b.clicked=true
					b.held=false
				else
					b.held=false
					b.clicked=false
				end
			else
				b.hovered=false
				b.held=false
				b.clicked=false
			end
		end
end

function draw_mouse_listeners()
	for n,b in pairs(listeners) do
		if b.held then
			b.held_drw()
		elseif b.hovered then
			b.hov_drw()
		else
			b.drw()
		end
	end
end
__gfx__
01000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17710000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17771000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17777100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17711000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000000003905039050390503a0503b050000003b050000003c050000003c0503c05000000000003c0503b0503a0503a05039050370500000000000000000000000000000000000000000000000000000000
