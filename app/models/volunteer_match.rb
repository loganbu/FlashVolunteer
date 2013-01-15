class VolunteerMatch
    def self.hello_world(name)
        call :helloWorld, {:name => name}.to_json
    end

    def self.get_key_status
        call :getKeyStatus, nil
    end

    def self.search_organizations(query)
        call :searchOrganizations, query.to_json
    end

    def self.search_opportunities(query)
        call :searchOpportunities, query.to_json
    end

    protected

    def self.api_key
        ENV['VM_API_KEY']
    end

    def self.account_name
        ENV['VM_API_SECRET']
    end

    def self.call(action, json_query)
        nonce           = Digest::SHA2.hexdigest(rand.to_s)[0, 20]
        creation_time   = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S%z")
        password_digest = Base64.encode64(Digest::SHA2.digest(nonce + creation_time + api_key)).chomp
        endpoint        = ENV['VM_API_ENDPOINT']
        url_s           = "http://#{endpoint}/api/call?action=#{action.to_s}"
        url_s           = json_query != nil ? url_s + "&query=" + URI.encode(json_query) : url_s
        url = URI.parse(url_s)

        req             = Net::HTTP::Get.new(url.request_uri)
        req.add_field('Content-Type', 'application/json')
        req.add_field('Authorization', 'WSSE profile="UsernameToken"')
        req.add_field('X-WSSE', 'UsernameToken Username="' + account_name + '", PasswordDigest="' + password_digest + '", ' +
            'Nonce="' + nonce + '", Created="' + creation_time + '"')

        res = Net::HTTP::Proxy('127.0.0.1', 8888).start(url.host, url.port) { |http| http.request(req) }
        raise "HTTP error code #{res.code} body #{res.body}" unless res.code == "200"
        OpenStruct.new(JSON.parse res.body)
    end
end