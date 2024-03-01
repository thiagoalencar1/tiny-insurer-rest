require 'rails_helper'

RSpec.describe Policy, type: :model do
  it "is_valid" do
    vehicle = Vehicle.create!(plate: "AAA-1111", brand: "Ford", model: "Fiesta", year: 2018)
    insured = Insured.create!(name: "Fulano Cicrano de Tal", cpf: "000.000.000-01")
    policy = Policy.new(
      insured_at: Time.now, insured_until: Time.now + 1.year, vehicle_id: vehicle.id, insured_id: insured.id
    )

    expect(policy).to be_valid
  end

  context "is_invalid" do
    let(:vehicle) { Vehicle.create!(plate: "AAA-1111", brand: "Ford", model: "Fiesta", year: 2018) }
    let(:insured) { Insured.create!(name: "Fulano Cicrano de Tal", cpf: "000.000.000-01") }

    it "if insured_at is missing" do
      policy = Policy.new(insured_until: Time.now + 1.year, vehicle_id: vehicle.id, insured_id: insured.id)
      
      policy.valid?
      
      expect(policy.errors.messages.include?(:insured_at)).to be true
    end

    it "if insured_until is missing" do
      policy = Policy.new(insured_at: Time.now, vehicle_id: vehicle.id, insured_id: insured.id)
      
      policy.valid?
      
      expect(policy.errors.messages.include?(:insured_until)).to be true
    end

    it "if insured_id is missing" do
      policy = Policy.new(insured_at: Time.now, insured_until: Time.now + 1.year, vehicle_id: vehicle.id)
      
      policy.valid?
      
      expect(policy.errors.messages.include?(:insured_id)).to be true
    end

    it "if vehicle_id is missing" do
      policy = Policy.new(insured_at: Time.now, insured_until: Time.now + 1.year, insured_id: insured.id)
      
      policy.valid?
      
      expect(policy.errors.messages.include?(:vehicle_id)).to be true
    end
  end
end
