class AddClientIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :client_id, :int
  end
end
