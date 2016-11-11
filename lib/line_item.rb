class LineItem
  attr_accessor :product, :quantity, :discount_amount

  def initialize(product)
    self.product = product
    self.quantity = 1
    self.discount_amount = 0.00
  end

  def subtotal
    product.price * quantity
  end

  def total
    subtotal - discount_amount
  end
end
