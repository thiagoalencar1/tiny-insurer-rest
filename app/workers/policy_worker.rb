# frozen_string_literal: true

require "sneakers"
require "json"

class PolicyWorker
  include Sneakers::Worker
  from_queue "create-policy"

  def work(msg)
    puts "::::::::::: MESSAGE RECEIVED ::::::::::"
    policy_data = JSON.parse(msg, symbolize_names: true)

    ActiveRecord::Base.connection_pool.with_connection do
      insured = Insured.find_or_create_by(cpf: policy_data[:insured][:cpf]) do |i|
        i.name = policy_data[:insured][:name]
      end

      vehicle = Vehicle.find_or_create_by(plate: policy_data[:vehicle][:plate]) do |v|
        v.brand = policy_data[:vehicle][:brand]
        v.model = policy_data[:vehicle][:model]
        v.year = policy_data[:vehicle][:year]
      end

      policy = Policy.create!(
        insured_at: policy_data[:insured_at],
        insured_until: policy_data[:insured_until],
        status: policy_data[:status],
        insured: insured,
        vehicle: vehicle
      )
      puts "######### POLICY CREATED: #{policy.id} #########"
      ack!
    end
  rescue StandardError => e
    ack!
    Sneakers.logger.error "ERROR: #{e.message}"
  end
end
