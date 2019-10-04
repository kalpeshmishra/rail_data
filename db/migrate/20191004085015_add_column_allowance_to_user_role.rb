class AddColumnAllowanceToUserRole < ActiveRecord::Migration[5.0]
  def change
  	add_column :user_roles, :is_allowance_access, :boolean
  end
end
