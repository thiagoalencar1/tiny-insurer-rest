class AddStatusToPolicy < ActiveRecord::Migration[7.1]
  def change
    add_column :policies, :status, :integer
  end
end
