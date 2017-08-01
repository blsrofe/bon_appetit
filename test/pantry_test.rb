require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/emoji'

class PantryTest < Minitest::Test

  def test_it_exists
    pantry = Pantry.new
    assert_instance_of Pantry, pantry
  end

  def test_it_starts_empty
    pantry = Pantry.new
    assert_equal ({}), pantry.stock
  end

  def test_it_can_check_for_ingredients
    pantry = Pantry.new
    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_it_can_be_restocked
    pantry = Pantry.new

    pantry.restock("Cheese", 10)
    assert_equal 10, pantry.stock_check("Cheese")

    pantry.restock("Cheese", 20)
    assert_equal 30, pantry.stock_check("Cheese")
  end

  def test_it_can_convert_units
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cayenne Pepper", 0.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 500)

    pantry = Pantry.new

    expected = {"Cayenne Pepper" => {quantity: 25, units: "Milli-Units"},
                "Cheese"         => {quantity: 75, units: "Universal Units"},
                "Flour"          => {quantity: 5, units: "Centi-Units"}}

    assert_equal expected, pantry.convert_units(r)
  end

  def test_it_can_transform_amounts_to_a_new_hash
    pantry = Pantry.new

    amount = 500
    expected = {quantity: 5, units: "Centi-Units"}
    assert_equal expected, pantry.transform(amount)

    amount_2 = 75
    expected_2 = {quantity: 75, units: "Universal Units"}
    assert_equal expected_2, pantry.transform(amount_2)

    amount_3 = 0.025
    expected_3 = {quantity: 25, units: "Milli-Units"}
    assert_equal expected_3, pantry.transform(amount_3)
  end

end
