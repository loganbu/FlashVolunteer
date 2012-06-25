require "rexml/document"
include REXML
namespace :fv do
    desc "Import data from 3rd party providers"
    task :import_third_party => :environment do
        ['AfgOpportunity'].each do |provider|
            provider.constantize.download_new_data
        end
    end
end

