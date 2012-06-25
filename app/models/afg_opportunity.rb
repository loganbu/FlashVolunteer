require 'net/http'
require 'active_support/time_with_zone'
class AfgOpportunity < ActiveRecord::Base

    before_save :reverse_geocode
    attr_accessor :geocoder_result

    scope :not_imported, lambda {
      where("imported = ?", false)
    }

    def self.rest_url(num_results, page)
        distance = 20
        location = "Seattle,WA"
        key = ENV['AFG_API_KEY']
        type = "all"
        url = "http://www.allforgood.org/api/volopps?vol_loc=#{location}&vol_dist=#{distance}&key=#{key}&merge=1&num=#{num_results}&type=all&page=#{page}&output=json"
        Rails.logger.info("Requesting #{url}")
        url
    end

    def self.download_new_data(num_results=50, page=1)
        Rails.logger.info("Getting page #{page} with #{num_results} results")
        data = JSON.parse(Net::HTTP.get(URI.parse(rest_url(num_results, page))))

        data['items'].each do |item|
            startTime = Time.zone.parse(item['startDate'] + " UTC")
            endTime = Time.zone.parse(item['endDate'] + " UTC")
            if (endTime > Time.now && startTime > Time.now)
                AfgOpportunity.find_or_create_by_key(item['id'],
                                                     :title => item['title'],
                                                     :description => item['description'],
                                                     :location_name => item['location_name'],
                                                     :startDate => startTime,
                                                     :endDate => endTime,
                                                     :sponsoringOrganizationName => item['sponsoringOrganizationName'],
                                                     :xml_url => item['xml_url'],
                                                     :skills => item['skills'],
                                                     :city => item['city'],
                                                     :latlong => item['latlong'])
            end
        end
    end

    def parse_latlong
        self.geocoder_result = Geocoder.search(latlong)[0]
        Rails.logger.debug(self.geocoder_result)
        self.geocoder_result
    end

    def reverse_geocode
        if (!self.reverse_geocoded)
            if(self.geocoder_result == nil)
                parse_latlong
            end

            if (self.geocoder_result)
                if (self.geocoder_result.address_components_of_type(:street_number).count > 0)
                    self.street = "#{self.geocoder_result.address_components_of_type(:street_number)[0]['long_name']} #{self.geocoder_result.address_components_of_type(:route)[0]['long_name']}"
                end

                if(self.geocoder_result.address_components_of_type(:neighborhood).count > 0)
                    self.neighborhood_string = self.geocoder_result.address_components_of_type(:neighborhood)[0]['long_name']
                else
                    self.neighborhood_string = nil
                end
                self.zip = self.geocoder_result.postal_code
            end
            self.reverse_geocoded = true
        end
    end

    # Helper methods to get street/neighborhood/zip
    def start
        startDate
    end

    def end
        endDate
    end

    def neighborhood
        Neighborhood.find_by_name(self.neighborhood_string)
    end
end
