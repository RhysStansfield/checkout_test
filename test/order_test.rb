require File.expand_path(File.join(__FILE__, '..', 'test_helper'))

class TestLineItem < Minitest::Test
  def setup
    @product = Product.new('001')
    @order = Order.new
  end

  def test_adding_product_to_order_creates_line_item
    assert_equal 0, @order.line_items.count

    @order.add(@product)

    assert_equal 1, @order.line_items.count
  end
end
