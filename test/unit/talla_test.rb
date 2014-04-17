require 'test_helper'

class TallaTest < ActiveSupport::TestCase
  test "validate_presence" do
  	talla = Talla.create
  	assert_equal 2, talla.errors.count
  end

  test "validate_uniqueness" do
  	talla = Talla.new(:nombre_euro => '44', :nombre_usa => 'XL')
  	assert (not talla.save)
  end
end
