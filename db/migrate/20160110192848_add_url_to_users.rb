class AddUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :URL, :string
  end
end
