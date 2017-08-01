require './lib/recipe'
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

  def convert_units(recipe)
    recipe.ingredients.map do |ingredient, amount|
      new_amount = transform(amount)
      recipe.ingredients[ingredient] = new_amount
    end
    recipe.ingredients
  end

  def transform(amount)
    transformed_collection = {}
    if amount > 100
      transformed_collection[:quantity] = amount * 100
      transformed_collection[:units] = "Centi-Units"
    elsif amount < 1
      transformed_collection[:quantity] = amount
      transformed_collection[:units] = "Milli-Units"
    else
      transformed_collection[:quantity] = amount / 1000
      transformed_collection[:units] = "Universal Units"
    end
    transformed_collection
  end

end
