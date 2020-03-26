class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  scope :recently_created, ->  { where(created_at: 1.minutes.ago..DateTime.now) }

  enum status: { pending: 0, failed: 1, paid: 2, executed: 3 }

  def set_paid
    self.status = Order.statuses[:paid]
  end

  def set_failed
    self.status = Order.statuses[:failed]
  end

  def set_executed
    self.status = Order.statuses[:executed]
  end
end
