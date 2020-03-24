class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  enum status: { pending: 0, failed: 1, paid: 2}

  def set_paid
    self.status = Order.statuses[:paid]
  end

  def set_failed
    self.status = Order.statuses[:failed]
  end
end
