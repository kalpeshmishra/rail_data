class CreateDakReceivers < ActiveRecord::Migration[5.0]
  def change
    create_table :dak_receivers do |t|
    	t.integer 	:dak_id
    	t.integer 	:reciever_user_id
    	t.boolean 	:is_read
    	t.date      :dak_read_time_date
      t.string		:extra
      t.timestamps
    end
  end
end
