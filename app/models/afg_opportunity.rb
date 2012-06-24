require 'net/http'
class AfgOpportunity < ActiveRecord::Base
    def self.rest_url
        distance = 20
        location = "Seattle,WA"
        key = ENV['flashvolunteer']
        num_results = 50
        type = "all"
        "http://www.allforgood.org/api/volopps?vol_loc=#{location}&vol_dist=#{distance}&key=#{key}&merge=1&num=#{num_results}&type=all&output=json"
    end

    def self.download_new_data
        data = JSON.parse(Net::HTTP.get(URI.parse(rest_url)))

        data['items'].each do |item|
            AfgOpportunity.find_or_create_by_key(item['id'],
                                                 :title => item['title'],
                                                 :location_name => item['location_name'],
                                                 :startDate => item['startDate'],
                                                 :endDate => item['endDate'],
                                                 :sponsoringOrganizationName => item['sponsoringOrganizationName'],
                                                 :xml_url => item['xml_url'],
                                                 :skills => item['skills'],
                                                 :city => item['city'])
        end
    end
end
