class Sponsor < ActiveRecord::Base
  has_attached_file :logo, :storage => :s3, :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY'],
      :secret_access_key => ENV['AWS_SECRET_KEY'],
      :bucket => ENV['AWS_BUCKET']
  }, :path => ":attachment/:id/:style.:extension",
  :styles => { :small => ["50x50#", :png]}

  scope :running, lambda {
    where("start_time <= ? AND end_time >= ?", DateTime.now, DateTime.now)
  }
end
