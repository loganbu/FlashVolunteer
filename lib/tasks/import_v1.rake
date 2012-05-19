require "rexml/document"
include REXML
namespace :fv do
    desc "Import data from Flash Volunteer, v1 XML data output"
    task :import_v1 => :environment do
        keyed = Hash.new
        ['Auth', 'Neighborhood', 'Volunteer'].each do |file|
            keyed[file] = Hash.new
            temp_file = File.new("#{Rails.root}/data/#{file}.xml")
            doc = Document.new temp_file
            doc.elements.each("//#{file}") do |e|
                n_key = e.elements['key'].text
                keyed[file][n_key] = e
            end    
        end

        v2_neighborhoods = Hash.new
        keyed['Neighborhood'].each do |neighborhood|
            v2_neighborhood = Neighborhood.find_by_name(neighborhood[1].elements["name"].text)
            if (v2_neighborhood != nil)
                v2_neighborhoods[neighborhood[1].elements["key"].text] = v2_neighborhood
            end
        end

        v2_users = Hash.new
        keyed['Auth'].each do |user|
            if (user[1].elements["strategy"].text == "Google" || user[1].elements["strategy"].text == "fv" || user[1].elements["strategy"].text == "Yahoo!")

                volunteer = keyed['Volunteer'][user[1].elements["user"].text]

                if (volunteer != nil)
                    neighborhood = volunteer.elements["home_neighborhood"].text
                    if (neighborhood != nil)
                        if (v2_neighborhoods[volunteer.elements["home_neighborhood"].text] == nil)
                            neighborhood = nil
                        else
                            neighborhood = v2_neighborhoods[volunteer.elements["home_neighborhood"].text].id
                        end
                    end
                    v2_user = User.find_or_create_by_email(volunteer.elements["preferred_email"].text,  :name=> volunteer.elements["name"].text,
                                                                                                        :neighborhood_id => neighborhood)

                    privacy = case volunteer.elements["privacy__event_attendance"].text
                        when "everyone"
                            "everyone"
                        when "friends"
                            "friends"
                        when "noone"
                            "self"
                    end
                    v2_privacy = Privacy.find_or_create_by_user_id(v2_user.id, :upcoming_events => privacy)

                    v2_users[user[1].elements["key"].text] = v2_user
                end
            end
        end
    end
end


##########
# Sample input data
##########
#<Volunteer>
#   <preferred_email>e-mail</preferred_email>
#   <account>forign key to account</account>
#   <verified>False</verified>
#   <name></name>
#   <home_neighborhood>foreign key to neighborhood</home_neighborhood>
#   <quote>User motto</quote>
#   <work_neighborhood>foreign key to neighborhood</work_neighborhood>
#   <joinedon>2012-01-01T00:00:00</joinedon>
#   <group_wheel>{bool} admin or not</group_wheel>
#   <session_id>no clue</session_id>
#   <applications>array of forign keys to Application, support multiple neighborhoods</applications>
#   <user>username</user>
#   <key></key>
#   <create_rights></create_rights>
#   <privacy__event_attendance>{noone|friends|everyone}</privacy__event_attendance>
#   <date_added>2012-01-01T00:00:00</date_added>
#   <avatar_type></avatar_type>
#</Volunteer>
#<Auth>
#   <account>forign key to account</account>
#   <strategy>{Google|Yahoo!|fv|MyOpenID}</strategy>
#   <user>foreign key to volunteer</user>
#   <key></key>
#   <identifier>Usually an e-mail address, but can be something else for openid or facebook</identifier>
#   <salt>Salt for this user</salt>
#   <digest2>doubly encripted key, for mobile?</digest2>
#   <digest>encrypted key</digest>
#</Auth>
#<Neighborhood>
#   <name>Central District</name>
#   <centroid_lat>47.607668</centroid_lat>
#   <application>Foreign key to application table</application>
#   <centroid>47.607668,-122.306328</centroid>
#   <key></key>
#   <centroid_lon>-122.306328</centroid_lon>
#</Neighborhood>