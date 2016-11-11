require File.expand_path(File.join(__FILE__, '..', 'test_helper'))

class TestLineItem < Minitest::Test
  def setup
    @product_1 = Product.new('001', 'Lavender', 5.00)
    @product_2 = Product.new('002', 'Shoes', 10.00)
    @order = Order.new
  end

  def test_adding_product_to_order_creates_line_item
    assert_equal 0, @order.line_items.count

    @order.add(@product_1)

    assert_equal 1, @order.line_items.count
  end

  def test_discount_amount
    assert_equal 0.0, @order.discount_amount

    @order.discount_amount += 1.00

    assert_equal 1.0, @order.discount_amount
  end

  def test_subtotal
    assert_equal 0.0, @order.subtotal

    @order.add(@product_1)

    assert_equal 5.0, @order.subtotal

    @order.add(@product_1)
    @order.line_items.first.discount_amount += 3.00

    assert_equal 7.0, @order.subtotal

    @order.add(@product_2)

    assert_equal 17.0, @order.subtotal
  end

  def test_total
    @order.add(@product_1)
    @order.discount_amount += 1.00

    assert_equal 4.0, @order.total
  end
end
