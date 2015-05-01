ruby '1.9.3'
source 'http://rubygems.org'

gem 'rails', '4.2.1'
gem 'json', '~> 1.7.7'

# Pagination
gem 'will_paginate', '~> 3.0'
# Authentication
gem 'devise', '~> 3.4'
# Authorization
gem 'cancan', '= 1.6.9'
# Geocoding
gem 'geocoder', '~> 1.2'
gem 'geoip', '~> 1.4'
# JQuery
gem 'jquery-rails', '~> 4.0'
# Not sure why directly gem'd
gem 'tlsmail'
# DatePicker
# gem 'jquery_datepicker'
# Export to iCal
gem 'icalendar', '~> 1.5'
# Not sure why directly gem'd
gem 'nokogiri', '~> 1.6'
# Advanced querying for records
gem "squeel"
# Good admin interface to the backend
gem 'rails_admin', '~> 0.6'
# API
gem 'grape'

# Delayed Jobs
gem 'delayed_job_active_record', '~> 4.0'
gem 'foreman'
gem 'hirefire-resource'

gem 'uglifier'
gem 'yui-compressor'

gem 'tzinfo-data'


# gems required to be exact version for ruby <2.0
gem 'execjs', '<= 2.2'
gem 'coffee-script-source', '<= 1.8'

gem 'sprockets-rails', '>= 2.1.4'
gem 'bootstrap-sass', '~> 3.3.4'
gem 'sass-rails', '>= 3.2'
gem 'compass', '~> 1.0'

gem 'aws-sdk', '< 2.0'
gem "paperclip", '~> 3.4'

gem "omniauth", '=1.1.3'
gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "omniauth-twitter"

gem 'wicked'
gem 'classy_enum', '~> 2.0.3'

gem 'sinatra', '1.0'
gem 'date_validator'
gem 'mysql2'

gem 'rgeo'
gem 'rgeo-geojson'

# 3.2 -> 4.0 upgrade, fix attr_accessible
gem 'protected_attributes'

# Source'd because this is the only repository which contains fixes for Rails 4.
# See https://github.com/rgeo/activerecord-mysql2spatial-adapter/issues/12
gem 'activerecord-mysql2spatial-adapter', :git => "https://github.com/agoln/activerecord-mysql2spatial-adapter/", :branch => "reorder_map_initialization"

gem 'newrelic_rpm'

group :development do
  gem 'factory_girl_rails'
  gem 'rails-footnotes'
  gem 'sqlite3'
  gem 'bullet'
end

group :production do
    # http://www.imagemagick.com/www/binary-releases.html#windows
    # https://github.com/rmagick/rmagick/wiki/Installing-on-Windows
    # LKG is 6.7.9.9 - http://ftp.sunet.se/pub/multimedia/graphics/ImageMagick/binaries/
    # http://ftp.sunet.se/pub/multimedia/graphics/ImageMagick/binaries/ImageMagick-6.7.7-0-Q16-windows-dll.exe
    # http://stackoverflow.com/questions/4451213/ruby-1-9-2-how-to-install-rmagick-on-windows
    gem "rmagick"
    gem "unicorn"
end
