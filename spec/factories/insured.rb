# frozen_string_literal: true

FactoryBot.define do
  factory :insured do
    name  { 'Jhon Doe of Silva' }
    cpf   { '000.000.000-00' }
  end

  factory :random_insured do
    name  { Faker::Name.name }
    cpf   { Faker::Name.brazilian_citizen_number(formattet: true) }
  end
end
