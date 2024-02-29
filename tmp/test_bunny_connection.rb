require 'bunny'
require 'json'

conn = Bunny.new(hostname: 'rabbitmq', username: 'admin', password: 'admin').start
ch = conn.create_channel
ch.confirm_select

q = ch.queue("create_policy", durable: true)

q.subscribe(manual_ack: true) do |delivery_info, metadata, payload| 
  puts "This is the message: #{payload}"
  # acknowledge the delivery so that RabbitMQ can mark it for deletion
  ch.ack(delivery_info.delivery_tag)
end

# publish a message to the default exchange which then gets routed to this queue
q.publish(
  {
    insured_at: Time.now,
    insured_until: Time.now,
    insured: {
      name: "Fulano de Tal",
      cpf: "001.002.003-04"
    },
    vehicle: {
      plate: "VIX-0099",
      brand: "Cherry",
      model: "QQ",
      year: 2024
    }
  }.to_json
)

# await confirmations from RabbitMQ, see
# https://www.rabbitmq.com/publishers.html#data-safety for details
ch.wait_for_confirms

# give the above consumer some time consume the delivery and print out the message
sleep 1

puts "Done"

ch.close
# close the connection
conn.close
