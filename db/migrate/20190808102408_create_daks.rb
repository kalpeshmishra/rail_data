class CreateDaks < ActiveRecord::Migration[5.0]
  def change
    create_table :daks do |t|
    	t.string 		:letter_type
    	t.string 		:letter_number
    	t.string    :letter_issue_date
    	t.string 		:letter_description
    	t.string    :creater_user_id
    	t.string    :dak_create_time
      t.date      :dak_create_date
      t.string		:extra
      t.timestamps
    end
  end
end
