class Affiliate < ActiveRecord::Base

  has_attached_file :logo, :storage => :s3, :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY'],
      :secret_access_key => ENV['AWS_SECRET_KEY'],
      :bucket => ENV['AWS_BUCKET']
  },
  :styles => { :thumb => ['32x32#', :png], :large => ['64X64#', :png]},
  :path => 'affiliates/:attachment/:id_:style.:extension', :default_url => '/assets/default_user_thumb.png'


  # Events that are affiliated with the same user
  scope :affiliated_with, lambda { |user|
    where{id.eq_any(user.affiliates)} unless user == nil
  }
end
