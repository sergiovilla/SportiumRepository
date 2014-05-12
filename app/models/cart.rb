class Cart < ActiveRecord::Base
  has_many :cart_items
  has_many :ropas, :through => :cart_items

  def add(ropa_id)
    items = cart_items.find_all_by_ropa_id ropa_id
    ropa = Ropa.find ropa_id
    if items.size < 1
      ci = cart_items.create :ropa_id => ropa_id, :cantidad => 1, :precio => ropa.precio
    else
      ci = items.first
      ci.update_attribute :cantidad, ci.cantidad + 1
    end
    ci
  end

  def remove(ropa_id)
    ci = cart_items.find_by_ropa_id ropa_id 
    if ci.cantidad > 1
      ci.update_attribute :cantidad, ci.cantidad - 1
    else
      CartItem.destroy ci.id
    end
    ci
  end

  def total
    sum = 0
    cart_items.each do |item| sum += item.precio * item.cantidad end
    sum
  end
end
