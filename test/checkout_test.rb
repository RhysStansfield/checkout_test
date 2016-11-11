require File.expand_path(File.join(__FILE__, '..', 'test_helper'))

class TestCheckout < Minitest::Test
  def setup
    @product = Product.new('001', 'Lavender', 5.00)
    @promotions = []
    @checkout = Checkout.new(@promotions)
  end

  def test_sets_passed_in_promotion_rules
    assert_same @promotions, @checkout.promotions
  end

  def test_creates_order
    assert_kind_of Order, @checkout.order
  end

  def test_can_scan_product
    assert_equal 0, @checkout.order.line_items.count

    @checkout.scan(@product)

    assert_equal 1, @checkout.order.line_items.count
  end

  def test_applies_promotions
    rule = -> (order) { order.total >= 15.00 }
    action = -> (order) { order.discount_amount = 5.00 }
    @checkout.promotions << Promotion.new(rule, action)

    3.times { @checkout.scan(@product) }

    assert_equal 10.0, @checkout.order.total
  end

  def test_total
    3.times { @checkout.scan(@product) }

    assert_equal '£15.00', @checkout.total
  end
end
