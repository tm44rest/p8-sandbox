-- refs: card

-- a deck is an ordered collection of cards, i.e. draw pile, discard pile, hand
-- self.cards = {1:[bottom card], 2:[second card], ..., m:[top card]}
_deck = {}
function _deck:shuffle()
  -- Knuth Shuffle
  local t = self.cards
  for x=0,count(t)-2 do
    local i=count(t)-x
    local j = flr(rnd(i))+1
    local temp = t[i]
    t[i] = t[j]
    t[j] = temp
  end
end
function _deck:add(crd,n)
  -- add card crd to this deck at position n
  -- precondition: 1 <= n <= size+1
  assert(n >= 1 and n <= count(self.cards)+1)
  assert(self.max == -1 or n <= self.max)
  if n == count(self.cards)+1 then add(self.cards,crd)
  else
    for i=n,count(self.cards) do
      local k = count(self.cards)+n-i
      self.cards[k+1]=self.cards[k]
    end
    self.cards[n]=crd
  end
end
function _deck:add_top(crd)
  -- add card crd to the top of this deck
  self:add(crd,count(self.cards)+1)
end
function _deck:add_bot(crd)
  -- add card crd to the bottom of this deck
  self:add(crd,1)
end
function _deck:add_rnd(crd)
  -- add card to a random position in this deck
  local r = flr(rnd(count(self.cards)))+1
  self:add(crd,r)
end
function _deck:remove(n)
  -- remove card at position n and return it
  -- precondition: 1 <= n <= size
  local c = self.cards[n]
  del(self.cards,self.cards[n])
  return c
end
function _deck:is_empty()
  return count(self.cards) == 0
end

function _deck:is_full()
  return self.max != -1 and count(self.cards) > self.max
end

-- creates an empty deck
function create_deck(max)
  local dck = {
    __index = _deck,
    cards = {},
    max = max or -1 -- max=-1 means no max deck size
  }
  setmetatable(dck,dck)
  return dck
end