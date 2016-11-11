class Order
  attr_accessor :line_items, :discount_amount

  def initialize
    self.line_items = []
    self.discount_amount = 0.00
  end

  def add(product)
    find_existing_line_item_and_add(product) || add_line_item_for(product)
  end

  def subtotal
    line_items.map(&:total).inject(0, :+)
  end

  def total
    subtotal - discount_amount
  end

  private

  def add_line_item_for(product)
    line_items << LineItem.new(product)
  end

  def find_existing_line_item_and_add(product)
    line_item = find_line_item_for(product)

    return unless line_item

    line_item.quantity += 1
  end

  def find_line_item_for(product)
    line_items.detect { |li| li.product.product_code == product.product_code }
  end
end
