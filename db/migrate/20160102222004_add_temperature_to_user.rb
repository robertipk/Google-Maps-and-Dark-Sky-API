class AddTemperatureToUser < ActiveRecord::Migration
  def change
    add_column :users, :temperature, :string
  end
end
