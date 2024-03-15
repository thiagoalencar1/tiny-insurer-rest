require 'rails_helper'

RSpec.describe "PoliciesControllers", type: :request do
  describe "GET /index" do
    xit "returns all policies with included information" do
      policy1 = create(:policy)
      policy2 = create(:policy)
      insured1 = create(:insured)
      insured2 = create(:insured)
      vehicle1 = create(:vehicle)
      vehicle2 = create(:vehicle)

      policy1.insured = insured1
      policy1.vehicle = vehicle1
      policy1.save

      policy2.insured = insured2
      policy2.vehicle = vehicle2
      policy2.save

      get :index

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([
        {
          "id" => policy1.id,
          "insured_at" => policy1.insured_at,
          "insured_until" => policy1.insured_until,
          "insured" => {
            "id" => insured1.id,
            "name" => insured1.name,
            "age" => insured1.age
          },
          "vehicle" => {
            "id" => vehicle1.id,
            "make" => vehicle1.make,
            "model" => vehicle1.model
          }
        },
        {
          "id" => policy2.id,
          "insured_at" => policy2.insured_at,
          "insured_until" => policy2.insured_until,
          "insured" => {
            "id" => insured2.id,
            "name" => insured2.name,
            "age" => insured2.age
          },
          "vehicle" => {
            "id" => vehicle2.id,
            "make" => vehicle2.make,
            "model" => vehicle2.model
          }
        }
      ])
    end
  end
end
