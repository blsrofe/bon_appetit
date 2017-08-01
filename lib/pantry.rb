require './lib/recipe'
class Pantry

  attr_reader :stock,
              :cookbook

  def initialize
    @stock = {}
    @cookbook = []
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
      transformed_collection[:quantity] = amount / 100
      transformed_collection[:units] = "Centi-Units"
    elsif amount < 1
      transformed_collection[:quantity] = amount * 1000
      transformed_collection[:units] = "Milli-Units"
    else
      transformed_collection[:quantity] = amount
      transformed_collection[:units] = "Universal Units"
    end
    transformed_collection
  end

  def add_to_cookbook(recipe)
    cookbook << recipe
  end

  def what_can_i_make
    suggestions = []
    cookbook.each do |recipe|
      if have_ingredients?(recipe)
        suggestions << recipe.name
      end
    end
    suggestions
  end

  def have_ingredients?(recipe)
    recipe.ingredients.each do |ingredient, amount|
      if stock[ingredient].nil?
        false
      elsif stock[ingredient] >= amount
        true
      else
        false
      end
    end
  end

end
