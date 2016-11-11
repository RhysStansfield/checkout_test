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
