class VolunteerMatch
    def self.hello_world(name)
        call :helloWorld, {:name => name}.to_json
    end

    def self.get_key_status
        call :getKeyStatus, nil
    end

    def self.get_opportunity_referrals(query)
        call :getOpportunityReferrals, query.to_json
    end

    def self.search_organizations(query)
        call :searchOrganizations, query.to_json
    end

    def self.search_opportunities(query)
        call :searchOpportunities, query.to_json
    end

    def self.search_members(query)
        call :searchMembers, query.to_json
    end

    def self.create_or_update_members(query)
        call :createOrUpdateMembers, query.to_json, :post
    end

    def self.sign_up_for_opportunity(member_id, opportunity_id)
        self.create_or_update_referrals({:oppId => opportunity_id, :referrals => [:member => {:primaryKey => member_id}, :commitmentStartDate=>"2013-01-01", :commitmentEndDate=>"2013-01-31"]})
    end

    def self.create_or_update_referrals(query)
        call :createOrUpdateReferrals, query.to_json, :post
    end

    def self.authentication_query(primary_key, password)
        nonce           = Digest::SHA2.hexdigest(rand.to_s)[0, 20]
        creation_time   = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S%z")
        password_digest = Base64.encode64(Digest::SHA2.digest(nonce + creation_time + password)).chomp
        {:primary_key => primary_key, :nonce => nonce, :creation_time => creation_time, :password_digest => password_digest}
    end

    protected

    def self.api_key
      ENV['VM_API_KEY']
      "2d34cde485580e694b1abd1d93016646"
    end

    def self.account_name
        ENV['VM_API_SECRET']
    end

    def self.endpoint
      ENV['VM_API_ENDPOINT']
      "www.volunteermatch.org"
    end

    def self.call(action, json_query, method=nil)
        nonce           = Digest::SHA2.hexdigest(rand.to_s)[0, 20]
        creation_time   = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S%z")
        password_digest = Base64.encode64(Digest::SHA2.digest(nonce + creation_time + api_key)).chomp
        endpoint        = self.endpoint
        url_s           = "http://#{endpoint}/api/call?action=#{action.to_s}"
        url_s           = json_query != nil ? url_s + "&query=" + URI.encode(json_query) : url_s
        url             = URI.parse(url_s)

        req = nil

        case method
        when :post
            req = Net::HTTP::Post.new(url.request_uri)
        else
            req = Net::HTTP::Get.new(url.request_uri)
        end

        req.add_field('Content-Type', 'application/json')
        req.add_field('Authorization', 'WSSE profile="UsernameToken"')
        req.add_field('X-WSSE', 'UsernameToken Username="' + account_name + '", PasswordDigest="' + password_digest + '", ' +
            'Nonce="' + nonce + '", Created="' + creation_time + '"')

        res = Net::HTTP::Proxy('127.0.0.1', 8888).start(url.host, url.port) { |http| http.request(req) }
        raise "HTTP error code #{res.code} body #{res.body}" unless res.code == "200"
        OpenStruct.new(JSON.parse res.body)
    end
end