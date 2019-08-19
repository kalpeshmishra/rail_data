class AddColumnToUserRole < ActiveRecord::Migration[5.0]
  def change
    add_column :user_roles, :is_statistics_access, :boolean
    add_column :user_roles, :is_dak_access, :boolean
    add_column :user_roles, :is_block__access, :boolean
  end
end
