# frozen_string_literal: true

require "sneakers"
require "json"

class PaymentWorker
  include Sneakers::Worker
  from_queue "payment-update"

  def work(msg)
    puts "::::::::::: PAYMENT RECEIVED ::::::::::"
    policy_data = JSON.parse(msg, symbolize_names: true)

    ActiveRecord::Base.connection_pool.with_connection do
      policy = Policy.find_by(payment_id: policy_data[:payment_id])
      policy.update!(status: 'active')

      puts "######### PAYMENT UPDATED #########"
      p policy

      # Notify success payment to backoffice
      url = URI(ENV['LIVE_CONFIRMATION_URL'])
      body = policy.to_json
      header = { 'Content-Type': 'application/json' }

      Net::HTTP.post(url, body, header)

      ack!
    end
  rescue StandardError => e
    ack!
    Sneakers.logger.error "ERROR: #{e.message}"
  end
end
