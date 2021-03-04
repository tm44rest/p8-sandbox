pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- basic control scheme
-- for most grid based games

function _init()
	-- delay auto shift
	das_delay=15
	rep_rate=4
	❎_mult=1 -- multiplier to das

	-- 0 1 2
	-- 3 4 5
	-- 6 7 8 
	dirx={0,1,-1,0,1,-1,0,1}
	diry={-1,-1,0,0,0,1,1,1}
	dirx[0]=-1
	diry[0]=-1
	
	inp_dir=0
	inp_dirtrue=0 -- what the game reads
	inp_rep=false
	inp_heldn=0 -- how long
	-- if changing from diagonal,
	-- pause cursor movement
	inp_diag_change=0
	
	-- map coords of cursor
	crsr_x=7
	crsr_y=7
end

function get_input()
	-- 0 1 2
	-- 3 4 5
	-- 6 7 8 
	new_dir=4
	if btn(⬅️) then
		new_dir-=1
	end
	if btn(➡️) then
		new_dir+=1
	end
	if btn(⬆️) then
		new_dir-=3
	end
	if btn(⬇️) then
		new_dir+=3
	end
	
	-- delay auto shift
	if new_dir==inp_dir then
		inp_heldn+=1*❎_mult
		if inp_rep then
			inp_heldn=inp_heldn%rep_rate
			if inp_heldn==0 then
				inp_dirtrue=new_dir
			else
				inp_dirtrue=4
			end
		else
			inp_heldn=inp_heldn%das_delay
			if inp_heldn==0 then
				inp_rep=true
				inp_dirtrue=new_dir
			else
				inp_dirtrue=4
			end
		end
	else
		inp_heldn=0
		inp_rep=false
		if inp_dir%2==0 and inp_dir!=4 then
			inp_dirtrue=4
		else
			inp_dirtrue=new_dir
		end
	end
	inp_dir=new_dir
	
	if btn(❎) then ❎_mult=2
	else ❎_mult=1
	end
end

function _update60()
	get_input()
	
 crsr_x+=dirx[inp_dirtrue]
 crsr_y+=diry[inp_dirtrue]
end

function _draw()
	cls()
	
	rect(crsr_x*8,crsr_y*8,crsr_x*8+7,crsr_y*8+7)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
