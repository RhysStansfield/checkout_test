require File.expand_path(File.join(__FILE__, '..', 'test_helper'))

class TestProduct < Minitest::Test
  def setup
    @product = Product.new('001', 'Lavender Heart', 9.25)
  end

  def test_product_has_product_code
    assert_equal '001', @product.product_code
  end

  def test_product_has_name
    assert_equal 'Lavender Heart', @product.name
  end

  def test_product_has_price
    assert_equal 9.25, @product.price
  end
end
