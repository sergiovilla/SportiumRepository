require 'test_helper'

class TallaTest < ActiveSupport::TestCase
  test "validate_presence" do
  	talla = Talla.create
  	assert_equal 4, talla.errors.count
  end

  test "validate_uniqueness" do
  	talla = Talla.new(:nombre_euro => '44', :nombre_usa => 'XL')
  	assert (not talla.save)
  end

  test "validate_usa" do
  	talla = Talla.create(:nombre_euro => '40', :nombre_usa => '1234')
  	assert_equal 2, talla.errors.count # USA sólo caracteres X,S,L,M y máximo 3 de longitud
  end

  test "validate_eu" do
  	talla = Talla.create(:nombre_euro => 'fds', :nombre_usa => 'XS')
  	assert_equal 1, talla.errors.count # EU no es un número
  end
end
