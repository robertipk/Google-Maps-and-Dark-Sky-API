class AddOffsetToUser < ActiveRecord::Migration
  def change
    add_column :users, :offset, :string
  end
end
