input_x = 0
input_x_turned = false 
input_jump = false
input_jump_pressed = 0

function update_input()
  local prev_x = input_x

  -- input_x
  if btn(0) then
    if btn(1) then
      -- turn around if left/right overlaps
      if input_x_turned then
        input_x = prev_x
      else
        input_x_turned = true
        input_x = -prev_x
      end
    else
      input_x_turned = false
      input_x = -1
    end
  elseif btn(1) then
    input_x_turned = false
    input_x = 1
  else
    input_x_turned = false
    input_x = 0
  end

  -- input_jump
	local jump = btn(4)
	if jump and not input_jump then		
		input_jump_pressed = 4  -- grace period
	else
		input_jump_pressed = jump and max(0, input_jump_pressed - 1) or 0
	end
	input_jump = jump
end