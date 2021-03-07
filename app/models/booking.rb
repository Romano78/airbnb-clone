class Booking < ApplicationRecord
  STATUS = %w[Pending Confirmed Cancelled]
  belongs_to :user
  belongs_to :flat
  validates :status, presence: true, inclusion: { in: STATUS }
end
