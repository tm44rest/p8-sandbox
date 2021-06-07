-- will probably refactor this at some point as i figure out what's needed
-- and what isn't needed
-- also this is absolutely flooding the global namespace LOL
cardtypes = {}
cards = {}

-- default card object
default = {}
default.name = "unimplemented"
default.abbreviation = "unimp"
default.description = "unimplemented"
default.cost = -1

function new_cardtype(type, rarity)
  -- type:
  -- 0 = atk
  -- 1 = skl
  -- rarity:
  -- 0 = basic
  -- 1 = common
  -- 2 = uncommon
  -- 3 = rare
  local crd = {
    __index = default,
    type = type
  }
  setmetatable(crd, crd)
  add(cardtypes, crd)
  return crd
end

function create(card)
  local crd = {
    __index = card
  }
  setmetatable(crd, crd)
  add(cards, crd)
  return crd  
end

-- test card
test = new_cardtype(0, 1)
test.name = "test"
test.abbreviation = "test"
test.description = "this is a test card"
test.cost = 0
function test:effect() end