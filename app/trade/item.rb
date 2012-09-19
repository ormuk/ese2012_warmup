class Item
  attr_accessor :name, :price, :owner, :state

  def initialize(name, price)
    @name = name
    @price = price
    @state = :inactive
  end

  def to_s
    "#{@name}, #{@price}"
  end
end