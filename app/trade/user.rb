class User
  attr_accessor :name, :credits, :items

  def initialize(name)
    @name = name
    #users start with 100 credits
    @credits = 100
    @items = Array.new
    self
  end


  def add_item(item)
    item.owner = self
    if (!@items.include?(item))
    @items.push(item)
    else
      puts "item already added to the list"
    end
  end

  def buy(item)
    if item.owner == self
       print("User #{@name} can't buy item #{item.name} from himself!\n")
    elsif item.state == :inactive
      print("User #{@name} can't buy item #{item.name} from user #{item.owner.name}, it's inactive.\n")
    elsif @credits < item.price
        print("User #{@name} does not have enough credits to buy item #{item.name} from user #{item.owner.name}.\n")
        #TODO Fehlermeldung oder Exception? Braucht es eine exception?
    else
      item.owner.credits = item.owner.credits + item.price
      item.owner.items.delete(item)
      @credits = @credits - item.price
      item.owner = self
      item.state = :inactive
      @items.push(item)
    end
  end

  def active_items
    active = @items.select {|item| item.state == :active}
  end

  def list_items_to_sell
    puts "Active items of user #{@name}:"
    active_items.each do |item|
      puts item
    end
    active_items
  end

  def list_items
    puts "All items of user #{@name}:"
    @items.each do |item|
      puts item
    end
  end

  def to_s
    "User #{@name}: #{@credits} credits, #{@items.length} items, #{active_items.length} items to sell.\n"
  end
end