class AddCloudindexToUsers < ActiveRecord::Migration
  def change
    add_column :users, :Cloudindex, :string
  end
end
