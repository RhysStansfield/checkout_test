require File.expand_path(File.join(__FILE__, '..', 'test_helper'))

MockOrder = Struct.new(:total)

class TestPromotion < Minitest::Test
  def setup
    @default_rule = Proc.new {}
    @default_action = Proc.new {}
    @default_promotion = Promotion.new(@default_rule, @default_action)
  end

  def test_takes_a_rule
    assert_same @default_rule, @default_promotion.rule
  end

  def test_can_have_actions
    assert_same @default_action, @default_promotion.action
  end

  def test_can_check_eligibility_for_an_order
    order_1 = MockOrder.new(9)
    order_2 = MockOrder.new(11)

    rule = Proc.new { |order| order.total > 10 }
    promotion = Promotion.new(rule, @default_action)

    assert_same false, promotion.eligible?(order_1)
    assert_same true, promotion.eligible?(order_2)
  end

  def test_can_perform_action_on_order
    order = MockOrder.new(10)
    action = Proc.new { |order| order.total = 8 }
    promotion = Promotion.new(@default_rule, action)

    assert_equal 10, order.total

    promotion.apply_to(order)

    assert_equal 8, order.total
  end
end

class TestTotalGreaterThanAmount < Minitest::Test
  def setup
    @rule = PromotionRule::TotalGreaterThanAmount.new(10)
  end

  def test_is_truty_when_order_total_above
    order = MockOrder.new(11)

    assert @rule.call(order)
  end

  def test_is_falsey_when_order_total_below
    order = MockOrder.new(9)

    assert !@rule.call(order)
  end
end

class TestTwoOrMoreOfItem < Minitest::Test
  def setup
    @rule = PromotionRule::QuantityOfProduct.new('001', 1)
    @product = Product.new('001', 'Mug', 5.00)
    @order = Order.new
    @order.add(@product)
  end

  def test_is_falsey_when_below_threshold
    assert !@rule.call(@order)
  end

  def test_is_truthy_when_above_threshold
    @order.add(@product)

    assert @rule.call(@order)
  end
end

class TestPercentageOffOrder < Minitest::Test
  def setup
    @action = PromotionAction::PercentageOffOrder.new(10)
    @product = Product.new('001', 'Mug', 5.00)
    @order = Order.new
    @order.add(@product)
  end

  def test_sets_discount_amount_on_order
    assert_equal 0.0, @order.discount_amount

    @action.call(@order)

    assert_equal 0.5, @order.discount_amount
  end
end

class TestDiscountLineItem
  def setup
    @action = PromotionAction::DiscountLineItem.new('001', 1.00)
    @product = Product.new('001', 'Mug', 5.00)
    @order = Order.new
    @order.add(@product)
  end

  def test_sets_discount_amount_on_line_item
    assert_equal 0.0, @order.line_items.first.discount_amount

    @action.call(@order)

    assert_equal 1.0, @order.line_items.first.discount_amount
  end

  def test_sets_discount_amount_on_line_item_for_each_duplicate
    assert_equal 0.0, @order.line_items.first.discount_amount

    @order.add(@product)
    @action.call(@order)

    assert_equal 2.0, @order.line_items.first.discount_amount
  end
end
