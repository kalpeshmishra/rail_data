class AddColumnToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_under, :string
  end
end
