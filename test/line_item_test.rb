require File.expand_path(File.join(__FILE__, '..', 'test_helper'))

class TestLineItem < Minitest::Test
  def setup
    @product = Product.new
    @line_item = LineItem.new(@product)
  end

  def test_takes_a_product
    assert_same @product, @line_item.product
  end

  def test_has_quantity
    assert_same 1, @line_item.quantity
  end
end
