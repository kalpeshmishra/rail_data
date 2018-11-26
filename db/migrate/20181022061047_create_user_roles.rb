class CreateUserRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_roles do |t|
      t.integer :user_id
      t.boolean :is_viewable, default: true
      t.boolean :is_admin, default: false
      t.boolean :is_superadmin, default: false
      t.boolean :is_subadmin, default: false
      t.boolean :rake_load_access, default: false
      t.boolean :one_rake_load_access, default: false
      t.boolean :two_rake_load_access, default: false
      t.boolean :other_load_access, default: false
      t.boolean :rake_unload_access, default: false
      t.boolean :one_rake_unload_access, default: false
      t.boolean :aecs_unload_access, default: false
      t.boolean :gets_unload_access, default: false
      t.boolean :unusual_occurrence_report_access, default: false
      t.timestamps
    end
  end
end
