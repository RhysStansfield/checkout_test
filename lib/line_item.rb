class LineItem
  attr_accessor :product, :quantity

  def initialize(product)
    self.product = product
    self.quantity = 1
  end
end
