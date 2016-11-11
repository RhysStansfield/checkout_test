class Order
  attr_accessor :line_items

  def initialize
    self.line_items = []
  end

  def add(product)
    find_existing_line_item_and_add(product) || add_line_item_for(product)
  end

  private

  def add_line_item_for(product)
    self.line_items += LineItem.new(product)
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
