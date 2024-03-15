# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Policy, type: :model do
  it 'is_valid' do
    vehicle = Vehicle.create!(plate: 'AAA-1111', brand: 'Ford', model: 'Fiesta', year: 2018)
    insured = Insured.create!(name: 'Fulano Cicrano de Tal', cpf: '000.000.000-01')
    policy = described_class.new(insured_at: Time.zone.now, insured_until: Time.zone.now + 1.year, vehicle_id: vehicle.id, insured_id: insured.id)
    expect(policy).to be_valid
  end

  context 'when missing' do
    let(:vehicle) { Vehicle.create!(plate: 'AAA-1111', brand: 'Ford', model: 'Fiesta', year: 2018) }
    let(:insured) { Insured.create!(name: 'Fulano Cicrano de Tal', cpf: '000.000.000-01') }

    it 'insured_at is invalid' do
      policy = described_class.new(insured_until: Time.zone.now + 1.year, vehicle_id: vehicle.id, insured_id: insured.id)

      policy.valid?

      expect(policy.errors.messages.include?(:insured_at)).to be true
    end

    it 'insured_until is invalid' do
      policy = described_class.new(insured_at: Time.zone.now, vehicle_id: vehicle.id, insured_id: insured.id)

      policy.valid?

      expect(policy.errors.messages.include?(:insured_until)).to be true
    end

    it 'insured_id is invalid' do
      policy = described_class.new(insured_at: Time.zone.now, insured_until: Time.zone.now + 1.year, vehicle_id: vehicle.id)

      policy.valid?

      expect(policy.errors.messages.include?(:insured_id)).to be true
    end

    it 'vehicle_id is invalid' do
      policy = described_class.new(insured_at: Time.zone.now, insured_until: Time.zone.now + 1.year, insured_id: insured.id)

      policy.valid?

      expect(policy.errors.messages.include?(:vehicle_id)).to be true
    end
  end
end
