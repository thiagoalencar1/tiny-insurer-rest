class Policy < ApplicationRecord
  belongs_to :insured
  belongs_to :vehicle

  accepts_nested_attributes_for :insured, :vehicle

  enum status: { pending: 0, active: 1 }

  validates :insured_at,    presence: true
  validates :insured_until, presence: true
  validates :insured_id,    presence: true
  validates :vehicle_id,    presence: true
end
