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

  def restock(ingredient, amount)
    if stock[ingredient.downcase].nil?
      stock[ingredient.downcase] = amount
    else
      stock[ingredient.downcase] += amount
    end
  end

end
