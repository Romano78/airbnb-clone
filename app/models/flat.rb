class Flat < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :global_search,
                  against: %i[name description],
                  using: {
                    tsearch: { prefix: true }
                  }

  belongs_to :user
  has_many :bookings
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true
  validates :description, presence: true
end
