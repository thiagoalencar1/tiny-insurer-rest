# frozen_string_literal: true

FactoryBot.define do
  factory :random_vehicle do
    plate { Faker::Vehicle.license_plate }
    brand { Faker::Vehicle.make }
    model { Faker::Vehicle.model(make_of_model: brand) }
    year  { Faker::Vehicle.year }
  end
end
