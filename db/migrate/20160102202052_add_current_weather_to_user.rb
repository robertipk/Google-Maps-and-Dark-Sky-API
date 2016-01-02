class AddCurrentWeatherToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_weather, :string
  end
end
