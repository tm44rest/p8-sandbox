function _init()
  -- initialize draw pile, hand, and discard pile
  draw_pile = create_deck(-1)
  discard_pile = create_deck(-1)
  hand = create_deck(10)

  -- create and add cards to draw pile, and shuffle them
  for i=1,30 do
    draw_pile:add_top(create_card(i))
  end
  draw_pile:shuffle()

  -- draw 5 cards
  for i=1,5 do
    draw_card()
  end

  -- create testing menu
  testing_menu = create_menu(2,3)
  testing_menu:add(create_button("view draw",10,20,56,8,view_draw),1,1)
  testing_menu:add(create_button("view discard",10,28,56,8),1,2)
  testing_menu:add(create_button("view hand",10,36,56,8,view_hand),1,3)
  testing_menu:add(create_button("draw card",66,20,56,8,draw_card),2,1)
  testing_menu:add(create_button("shuffle draw",66,28,56,8,shuffle_draw),2,2)
  testing_menu:add(create_button("reshuffle",66,36,56,8),2,3)

  displayed_menu = testing_menu
end

function _update()
  displayed_menu:update()
end

function _draw()
  cls()
  displayed_menu:draw()
end


-- player functions
function draw_card()
  if count(hand.cards) < hand.max then
    hand:add_top(draw_pile:remove(count(draw_pile.cards)))
  end
end

function shuffle_draw()
  draw_pile:shuffle()
end

function play_card(n)
  -- play card in position n from hand, resolve its effect, and discard it
  -- precondition: 1 <= n <= number of cards in hand
end

function discard_card(n)
  -- discard card in position n from hand
  -- precondition: 1 <= n <= number of cards in hand
  discard_pile:add_top(hand:remove(n))
end

function view_hand()
  local d = create_menu(1,11)
  d:add(create_button("back",0,0,36,8,view_testing_menu),1,1)
  for i,c in pairs(hand.cards) do
    local f = function ()
      discard_card(i)
      view_hand()
      displayed_menu.selected.row=i+1
      if i == count(hand.cards)+1 then displayed_menu.selected.row=i end
    end
    d:add(create_button(c.n,0,8*i,36,8,f),1,i+1)
  end
  displayed_menu = d
end

function view_discard()
  local d = create_menu(3,10)
  local n = count(discard_pile.cards)
  for i,c in pairs(discard_pile.cards) do

  end
  displayed_menu = d
end

function view_draw()
  local d = create_menu(3,10)
  local n = count(draw_pile.cards)
  for i,c in pairs(draw_pile.cards) do
    local x = flr((n-i)/10)+1
    local y = (n-i+1)%10
    if y == 0 then y = 10 end
    local s = i..": "
    if i == n then s = "top: "
    elseif i == 1 then s = "bot: " end
    d:add(create_button(s .. c.n,36*(x-1),8*y,36,8,view_testing_menu),x,y)
  end
  displayed_menu = d
end

function view_testing_menu()
  displayed_menu = testing_menu
end