require "test/unit"
require "../app/trade/item"
require "../app/trade/user"

class ItemTest < Test::Unit::TestCase

  def test_create_item
    item = Item.new("book", 25)
    assert(item.name == "book")
    assert(item.price == 25)
    assert(item.state == :inactive)
    assert(item.owner.nil?)
  end

  def test_to_s
    item = Item.new("book", 25)
    user = User.new("Peter")
    item.owner = user
    puts item.to_s
    assert(item.to_s == "book (25) with state inactive owned by Peter")
  end

end