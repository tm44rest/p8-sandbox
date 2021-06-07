-- current setup is flooding the global namespace but lol who cares

function switch_controller(ctrl)
  controller = ctrl
  ctrl.init()
end

titlescreen = {}
function titlescreen:init() end
function titlescreen:update()
  if btn(5) or btn(4) then
    switch_controller(combat)
  end
end
function titlescreen:draw()
  cls()
  print("card game :)", 32, 40)
end

combat = {}
function combat:init() 
  hand = {}
  for i=0,8 do
    add(hand,create(test))
  end
end
function combat:update()

end
function combat:draw()
  cls()

  -- draw menu borders
  line(0,72,127,72,7)
  line(28,72,28,127,7)
  line(0,72,0,127,7)
  line(0,127,127,127,7)
  line(127,72,127,127,7)
  line(56,72,56,127,7)
  for j=0,5 do
    line(0,80+j*8,56,80+j*8,7)
  end

  -- draw hand
  for n,c in pairs(hand) do
    -- clean this up
    if n < 6 then
      print(c.abbreviation,2,66+n*8)
      print(c.cost,24,66+n*8)
    else
      print(c.abbreviation,30,66+(n-5)*8)
      print(c.cost,52,66+(n-5)*8)
    end
  end

end