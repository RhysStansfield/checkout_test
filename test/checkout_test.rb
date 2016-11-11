require File.expand_path(File.join(__FILE__, '..', 'test_helper'))

class TestCheckout < Minitest::Test
  attr_accessor :checkout

  def setup
    promotions = []
    self.checkout = Checkout.new(promotions)
  end
end
