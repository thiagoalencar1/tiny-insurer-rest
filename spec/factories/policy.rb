# frozen_string_literal: true

FactoryBot.define do
  factory :policy do
    insured_at      { Time.zone.now }
    insured_until   { Time.zone.now + 1.year }
    insured         { association :random_insured }
    vehicle         { association :random_vehicle }
  end
end
