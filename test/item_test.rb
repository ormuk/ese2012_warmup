require "test/unit"
require "../app/trade/item"

class ItemTest < Test::Unit::TestCase

  def test_create_item
    item = Item.new("book", 25)
    assert(item.name == "book")
    assert(item.price == 25)
    assert(item.state == :inactive)
  end

end