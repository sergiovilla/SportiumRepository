require 'test_helper'

class TallaTest < ActiveSupport::TestCase
  test "validate_presence" do
  	talla = Talla.create
  	assert_equal 1, talla.errors.count
  end

  test "validate_uniqueness" do
  	talla = Talla.new(:nombre => 'XL')
  	assert (not talla.save)
  end
end
