class Affiliate < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => 'user_affiliations'
  has_and_belongs_to_many :events, :join_table => 'event_affiliations'

  has_attached_file :logo, :storage => :s3, :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY'],
      :secret_access_key => ENV['AWS_SECRET_KEY'],
      :bucket => ENV['AWS_BUCKET']
  },
  :styles => { :thumb => ['32x32#', :png], :large => ['64X64#', :png]},
  :path => 'affiliates/:attachment/:id_:style.:extension', :default_url => '/assets/default_user_thumb.png'

end
