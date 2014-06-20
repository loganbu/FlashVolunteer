Geocoder.configure(ip_lookup: :maxmind_local, maxmind_local: {file: File.join(Rails.root, 'db', 'data', 'GeoLite2-City.mmdb')})
