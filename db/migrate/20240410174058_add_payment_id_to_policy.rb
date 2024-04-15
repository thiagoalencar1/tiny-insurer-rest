class AddPaymentIdToPolicy < ActiveRecord::Migration[7.1]
  def change
    add_column :policies, :payment_id, :string
  end
end
