class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :items, class_name: 'OrderItem'

  validates :customer_id, presence: true
  validates :items, length: { minimum: 1 }, if: :completed?

  scope :open, -> { where completed: false }
  scope :completed, -> { where completed: true }

  def total
    items.to_a.sum(&:total)
  end
end