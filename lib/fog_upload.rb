class FogUpload

  def initialize( key = nil, body = nil, create = false )
    
    FogUpload.establish_connection!

    @file_object = directory.files.get( key ) if key.present? and !create

    if create
      @file_object = directory.files.new({
        :key => key,
        :body => body,
        :public => false 
      })
      
      @file_object.save
    end
    
  end

  def destroy!
    @file_object.destroy
  end

  def private_url
    @file_object.url( ::Fog::Time.now + 3600 ) rescue ""
  end

  def directory
    @@directory_var ||= @@connection.directories.find( "AWS_BUCKET" ).first
  end



  # class level methods

  def self.establish_connection!
    @@connection ||= Fog::Storage.new({ 
                      :provider => 'AWS',
                      :aws_access_key_id => "AWS_ACCESS_KEY_ID",
                      :aws_secret_access_key => "AWS_SECRET_ACCESS_KEY",
                      :region => "AWS_REGION"
                    })
  end

  def self.create( key, body )
    FogUpload.new( key, body, true)
  end

  def self.get_url( key )
    FogUpload.establish_connection!

    @@directory ||= @@connection.directories.find( "AWS_BUCKET" ).first

    # file_name = key.gsub(/reports\/[0-9]* /, '').gsub(/, /, '-').gsub(/,/)
    # sanitize the file name, remove reports/ path and remove commas.
    file_name = key.gsub(/reports\//, '').gsub(/,[ ]*/, '-')

    @@directory.files.new( { :key => key } ).url( ::Fog::Time.now + 600, :query => { 'response-content-disposition' => "attachment; filename=#{file_name}" } )

  end

end
