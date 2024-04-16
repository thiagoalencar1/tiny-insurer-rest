class AddPaymentLinkToPolicy < ActiveRecord::Migration[7.1]
  def change
    add_column :policies, :payment_link, :string
  end
end
