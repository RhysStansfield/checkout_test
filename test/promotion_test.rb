require File.expand_path(File.join(__FILE__, '..', 'test_helper'))

class TestPromotion < Minitest::Test
  Order = Struct.new(:total)

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
    order_1 = Order.new(9)
    order_2 = Order.new(11)

    rule = Proc.new { |order| order.total > 10 }
    promotion = Promotion.new(rule, @default_action)

    assert_same false, promotion.eligible?(order_1)
    assert_same true, promotion.eligible?(order_2)
  end

  def test_can_perform_action_on_order
    order = Order.new(10)
    action = Proc.new { |order| order.total = 8 }
    promotion = Promotion.new(@default_rule, action)

    assert_equal 10, order.total

    promotion.apply_to(order)

    assert_equal 8, order.total
  end
end
