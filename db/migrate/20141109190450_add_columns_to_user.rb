class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :secret, :string
    add_column :users, :token, :string
  end
end
