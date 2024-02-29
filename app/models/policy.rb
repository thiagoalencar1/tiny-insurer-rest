class Policy < ApplicationRecord
  belongs_to :insured
  belongs_to :vehicle

  accepts_nested_attributes_for :insured, :vehicle
end
