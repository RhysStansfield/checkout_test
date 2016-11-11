class Checkout
  attr_accessor :order, :promotions

  def initialize(promotions)
    self.order = Order.new
    self.promotions = promotions
  end

  def scan(product)
    reset_discount_amounts

    order.add(product)

    apply_promotions

    self
  end

  def total
    "£#{sprintf('%05.2f', order.total.round(2))}"
  end

  private

  def apply_promotions
    eligible_promotions.each { |promotion| promotion.apply_to(order) }
  end

  def eligible_promotions
    promotions.select { |promotion| promotion.eligible?(order) }
  end

  def reset_discount_amounts
    order.discount_amount = 0.00
    order.line_items.each { |line_item| line_item.discount_amount = 0.0 }
  end
end
