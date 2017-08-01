class Pantry

  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(ingredient)
    if stock[ingredient.downcase].nil?
      0
    else
      stock[ingredient.downcase]
    end
  end

end
