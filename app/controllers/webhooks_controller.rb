# frozen_string_literal: true

class WebhooksController < ApplicationController
  # server.rb
  #
  # Use this sample code to handle webhook events in your integration.
  #
  # 1) Paste this code into a new file (server.rb)
  #
  # 2) Install dependencies
  #   gem install sinatra
  #   gem install stripe
  #
  # 3) Run the server on http://localhost:4242
  #   ruby server.rb

  # The library needs to be configured with your account's secret key.
  # Ensure the key is kept out of any version control system you might be using.
  # Stripe.api_key = 'sk_test_...'

  # This is your Stripe CLI webhook secret for testing your endpoint locally.
  ENDPOINT_SECRET = 'whsec_IcXAvcyWkUliyCPncX6qddPsxNBIo7hy'
  # whsec_IcXAvcyWkUliyCPncX6qddPsxNBIo7hy

  # set :port, 4242

  def update
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']

    event = Stripe::Webhook.construct_event(
      payload, sig_header, ENDPOINT_SECRET
    )

    # Handle the event
    case event.type
    when 'checkout.session.async_payment_failed'
      session = event.data.object
    when 'checkout.session.async_paymenceeded'
      session = event.data.object
    when 'checkout.session.completed'
      session = event.data.object
      policy = Policy.find_by(payment_id: session.id)
      policy.update(status: 'active')

      status 200
    when 'checkout.session.expired'
      session = event.data.object
    # ... handle other event types
    else
      puts "Unhandled event type: #{event.type}"
    end

    status 200
  end
end
