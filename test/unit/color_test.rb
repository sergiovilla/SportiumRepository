require 'test_helper'

class ColorTest < ActiveSupport::TestCase
  test "validate_presence" do
  	color = Color.create
  	assert_equal 1, color.errors.count
  end

  test "validate_uniqueness" do
  	color = Color.new(:nombre => 'Rojo')
  	assert (not color.save)
  end
end
