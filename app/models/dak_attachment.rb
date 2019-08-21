class DakAttachment < ApplicationRecord
	belongs_to :dak
	def url
    ::FogUpload.get_url(attachment_path) if attachment_path.present?
	end

end
