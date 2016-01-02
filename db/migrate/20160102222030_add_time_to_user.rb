class AddTimeToUser < ActiveRecord::Migration
  def change
    add_column :users, :time, :string
  end
end
