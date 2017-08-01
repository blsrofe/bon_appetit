require './lib/recipe'
require 'pry'
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
    true_or_false = recipe.ingredients.map do |ingredient, amount|
      if stock[ingredient.downcase].nil?
        false
      elsif stock[ingredient.downcase] >= amount
        true
      else
        false
      end
    end
    true_or_false.all? do |boolean|
      boolean == true
    end
  end

  def how_many_can_i_make
    suggestions = {}
    cookbook.each do |recipe|
      if have_ingredients?(recipe)
        number = how_many(recipe)
        suggestions[recipe.name] = number
      end
    end
    suggestions
  end

  def how_many(recipe)
    amount_possible = []
    recipe.ingredients.each do |ingredient, amount|
      pantry_amount = stock[ingredient.downcase]
      amount_possible << pantry_amount/amount
    end
    amount_possible.min
  end

end
