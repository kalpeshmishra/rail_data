class CreateDaks < ActiveRecord::Migration[5.0]
  def change
    create_table :daks do |t|
    	t.string 		:letter_type
    	t.string 		:letter_number
    	t.string    :letter_issue_date
    	t.string 		:letter_description
    	t.integer   :creater_user_id
    	t.datetime  :dak_create_at
      t.string		:extra
      t.timestamps
    end
  end
end
