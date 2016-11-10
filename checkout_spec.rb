require 'minitest/autorun'
require 'minitest/pride'

require './checkout'

describe Checkout do
  before do
    promotions = []
    @checkout = Checkout.new(promotions)
  end

  it 'must apply 10% discount when value over 60' do
    @checkout.total.must_equal '£68.78'
  end

  it 'must discount multiple lavender Hearts to 8.50' do
    @checkout.total.must_equal '£36.95'
  end

  it 'must apply all applicable promotions' do
    @checkout.total.must_equal '£73.76'
  end
end
