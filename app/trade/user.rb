class User
  attr_accessor :name, :credits, :items

  def initialize(name)
    self.name = name
    #users start with 100 credits
    self.credits = 100
    self.items = Array.new
    self
  end


  def add_item(item)
    item.owner = self
    if self.items.include?(item)
      puts "item already added to the list"
    else
      self.items.push(item)
    end
  end

  def buy(item)
    if item.owner == self
       print("User #{self.name} can't buy item #{item.name} from himself!\n")
    elsif item.state == :inactive
      print("User #{self.name} can't buy item #{item.name} from user #{item.owner.name}, it's inactive.\n")
    elsif self.credits < item.price
        print("User #{self.name} does not have enough credits to buy item #{item.name} from user #{item.owner.name}.\n")
    else
      item.owner.credits = item.owner.credits + item.price
      item.owner.items.delete(item)
      self.credits  -= item.price
      item.owner = self
      item.state = :inactive
      self.items.push(item)
    end
  end

  def active_items
    active = self.items.select {|item| item.state == :active}
  end

  def list_items_to_sell
    puts "Active items of user #{self.name}:"
    self.active_items.each do |item|
      puts item
    end
    active_items
  end

  def list_items
    puts "All items of user #{self.name}:"
    self.items.each do |item|
      puts item
    end
  end

  def to_s
    "User #{self.name}: #{self.credits} credits, #{self.items.length} items, #{active_items.length} items to sell.\n"
  end
end