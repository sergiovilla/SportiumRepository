class CartItem < ActiveRecord::Base
  attr_accessible :ropa_id, :cart_id, :precio, :cantidad

  belongs_to :cart
  belongs_to :ropa
end
