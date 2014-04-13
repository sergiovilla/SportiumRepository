require 'test_helper'

class PieTest < ActiveSupport::TestCase
  test "validate_presence" do
  	pie = Pie.create
  	assert_not_empty pie.errors
  end

  test "validate_uniqueness" do
  	pie = Pie.new(:numero => 40)
  	assert (not pie.save)
  end

  test "validate_only_integer" do
  	pie = Pie.create(:numero => 'L')
  	assert_equal 1, pie.errors.count
  end

  test "validate_greater_than" do
  	pie = Pie.create(:numero => 20)
  	assert_equal 1, pie.errors.count
  end

  test "validate_less_than" do
  	pie = Pie.create(:numero => 65)
  	assert_equal 1, pie.errors.count
  end
end
