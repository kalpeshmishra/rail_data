class CreateDakAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :dak_attachments do |t|
    	t.integer 	:dak_id
    	t.string 		:attachment_type
    	t.string 		:attachment_path
    	t.string 		:extra_path
      t.timestamps
    end
  end
end
