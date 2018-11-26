class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
    	t.string :name
	    t.string :code
	    t.datetime :created_at, null: false
	    t.datetime :updated_at, null: false
      t.timestamps
    end
  end
end
