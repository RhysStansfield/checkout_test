require 'minitest/autorun'
require 'minitest/pride'

require './checkout'

class TestCheckout < Minitest::Test
  attr_accessor :checkout

  def setup
    promotions = []
    self.checkout = Checkout.new(promotions)
  end
end
