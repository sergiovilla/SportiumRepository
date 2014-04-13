require 'test_helper'

class MarcaTest < ActiveSupport::TestCase
  test "validate_presence" do
  	marca = Marca.create
  	assert_equal 2, marca.errors.count
  end

  test "validate_uniqueness" do
  	marca = Marca.new(:nombre => 'Adidas', :pais => 'Eslovaquia')
  	assert (not marca.save)
  end
end
