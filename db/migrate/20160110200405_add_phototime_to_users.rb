class AddPhototimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :Phototime, :string
  end
end
