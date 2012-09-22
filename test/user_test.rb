require "test/unit"
require "../app/trade/user"
require "../app/trade/item"

class UserTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @suti = User.new("Suti")
    @florian = User.new("Florian")
    @macbook = Item.new("macbook",50)
    @ipod = Item.new("ipod",50)
    @iphone = Item.new("iphone", 50)
  end

  def test_create_user
    hans = User.new("Hans")
    assert(hans.name == "Hans")
    assert(hans.credits == 100)
    assert(hans.items.empty?)
  end

  def test_add_items
    @suti.add_item(@macbook)
    @suti.add_item(@ipod)

    assert(@suti.items.length == 2)
    assert(@suti.items.include?(@macbook))
    assert(@suti.items.include?(@ipod))
  end


  def test_list_items_to_sell
    macbook = Item.new("macbook",50)
    ipod = Item.new("ipod",50)

    @suti.add_item(macbook)
    @suti.add_item(ipod)

    macbook.state = :active
    assert(@suti.list_items_to_sell.length == 1)
    ipod.state = :active
    assert(@suti.list_items_to_sell.length == 2)
  end

  def test_buy
    macbook = Item.new("macbook",50)
    ipod = Item.new("macbook",50)

    @suti.add_item(macbook)
    @suti.add_item(ipod)

    @suti.list_items
    @suti.list_items_to_sell
    macbook.state = :active

    @florian.buy(macbook)
    assert(@florian.items.include?(macbook), "florian should have the macbook now")
    assert(macbook.owner = @florian)
    assert(@florian.credits == 50, "florian should now have 50 credits")
    assert(macbook.state = :inactive)
    assert(!@suti.items.include?(macbook), "suti should not have the macbook anymore")
    assert(@suti.credits == 150, "suti should now have 50 credits")
  end

  def test_buy_fail_credits
     @suti.add_item(@macbook)
     @suti.add_item(@ipod)
     @suti.add_item(@iphone)
     @macbook.state= :active
     @iphone.state= :active
     @ipod.state= :active
     @florian.buy(@macbook)
     @florian.buy(@ipod)
     @suti.buy(@iphone)
     @florian.buy(@iphone)
  end

  def test_buy_fail_state
    #TODO buy a item with state :inactive
  end


  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

end