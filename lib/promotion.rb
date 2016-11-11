class Promotion
  attr_accessor :rule, :action

  def initialize(rule, action)
    self.rule = rule
    self.action = action
  end

  def apply_to(order)
    action.call(order)
  end

  def eligible?(order)
    rule.call(order)
  end
end

module PromotionRule
  class TotalGreaterThanAmount
    attr_accessor :amount

    def initialize(amount)
      self.amount = amount
    end

    def call(order)
      order.total > amount
    end
  end

  class QuantityOfProduct
    attr_accessor :product_code, :quantity

    def initialize(product_code, quantity)
      self.product_code = product_code
      self.quantity = quantity
    end

    def call(order)
      relevant_line_item = find_relevant_line_item_from(order)

      !!relevant_line_item && relevant_line_item.quantity > quantity
    end

    private

    def find_relevant_line_item_from(order)
      order.line_items.detect do |line_item|
        line_item.product.product_code == product_code
      end
    end
  end
end

module PromotionAction
  class PercentageOffOrder
    attr_accessor :percentage

    def initialize(percentage)
      self.percentage = percentage
    end

    def call(order)
      order.discount_amount = order.total / percentage
    end
  end

  class DiscountLineItem
    attr_accessor :product_code, :discount_amount

    def initialize(product_code, discount_amount)
      self.product_code = product_code
      self.discount_amount = discount_amount
    end

    def call(order)
      relevant_line_item = find_relevant_line_item_from(order)

      relevant_line_item.discount_amount = discount_amount * relevant_line_item.quantity
    end

    private

    def find_relevant_line_item_from(order)
      order.line_items.detect do |line_item|
        line_item.product.product_code == product_code
      end
    end
  end
end
