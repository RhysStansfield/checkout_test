require File.expand_path(File.join(__FILE__, '..', 'test_helper'))

describe Checkout do
  before do
    setup_products
    setup_promotions
    @checkout = Checkout.new(@promotions)
  end

  it 'must apply 10% discount when value over 60' do
    @checkout.scan(@product_1)
    @checkout.scan(@product_2)
    @checkout.scan(@product_3)

    @checkout.total.must_equal '£66.78'
  end

  it 'must discount multiple lavender Hearts to 8.50' do
    @checkout.scan(@product_1)
    @checkout.scan(@product_3)
    @checkout.scan(@product_1)

    @checkout.total.must_equal '£36.95'
  end

  it 'must apply all applicable promotions' do
    @checkout.scan(@product_1)
    @checkout.scan(@product_2)
    @checkout.scan(@product_1)
    @checkout.scan(@product_3)

    @checkout.total.must_equal '£73.76'
  end

  def hearts_finder(order)
    order.line_items.detect do |line_item|
      line_item.product.product_code == '001'
    end
  end

  def setup_products
    @product_1 = Product.new('001', 'Lavender heart', 9.25)
    @product_2 = Product.new('002', 'Personalised cufflinks', 45.00)
    @product_3 = Product.new('003', 'Kids T-shirt', 19.95)
  end

  def setup_promotions
    rule_1 = PromotionRule::QuantityOfProduct.new('001', 1)
    action_1 = PromotionAction::DiscountLineItem.new('001', 0.75)

    rule_2 = PromotionRule::TotalGreaterThanAmount.new(60.00)
    action_2 = PromotionAction::PercentageOffOrder.new(10)


    @promotions = [Promotion.new(rule_1, action_1), Promotion.new(rule_2, action_2)]
  end
end
