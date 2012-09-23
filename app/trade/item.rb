class Item
  attr_accessor :name, :price, :owner, :state

  def initialize(name, price)
    self.name = name
    self.price = price
    self.state = :inactive
  end

  def to_s
    "#{self.name} (#{self.price}) with state #{self.state} owned by #{self.owner.name}"
  end
end