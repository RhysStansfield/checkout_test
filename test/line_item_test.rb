require File.expand_path(File.join(__FILE__, '..', 'test_helper'))

class TestLineItem < Minitest::Test
  def setup
    @product = Product.new('001', 'Lavender', 5.00)
    @line_item = LineItem.new(@product)
  end

  def test_takes_a_product
    assert_same @product, @line_item.product
  end

  def test_has_quantity
    assert_equal 1, @line_item.quantity
  end

  def test_has_subtotal
    assert_equal 5.00, @line_item.subtotal
  end

  def test_has_discount_amount
    assert_equal 0.00, @line_item.discount_amount
  end

  def test_has_total_affected_by_discount_amount
    assert_equal 5.00, @line_item.total

    @line_item.discount_amount = 1.00

    assert_equal 4.00, @line_item.total
  end
end
