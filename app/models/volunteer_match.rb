class VolunteerMatch < ActiveRecord::Base
  attr_accessor :geocoder_result

  scope :not_imported, lambda {
    where('imported = ?', false)
  }

  def self.update(pages_of_results, page_number=1, location='Seattle, WA')
    start_day = 1.week.ago
    end_day = 9.months.from_now

    (page_number..pages_of_results).each do |page|
      results = VolunteerMatch.search_opportunities({fieldsToDisplay:
                                                         [:allowGroupInvitations, :allowGroupReservation,
                                                          :availability, :beneficiary, :categoryIds, :contact,
                                                          :created, :currentPage, :description, :greatFor,
                                                          :hasWaitList, :id, :imageUrl, :location, :minimumAge,
                                                          :numReferred, :parentOrg, :plaintextDescription,
                                                          :plaintextRequirements, :plaintextSkillsNeeded,
                                                          :referralFields, :requirements, :requirementsMap,
                                                          :requiresAddress, :resultsSize, :skillsList,
                                                          :skillsNeeded, :spacesAvailable, :status, :tags,
                                                          :title, :type, :updated, :virtual, :vmUrl,
                                                          :volunteersNeeded],
                                                     dateRanges: [{
                                                                     startDate: start_day.strftime('%Y-%m-%d'),
                                                                     endDate: end_day.strftime('%Y-%m-%d'),
                                                                     singleDayOpps: true}],
                                                     location: location,
                                                     pageNumber: page.to_i})

      results.opportunities.each do |opportunity|
        if opportunity['referralFields'] == nil
          vm_opportunity = VolunteerMatch.find_or_initialize_by_vm_id(opportunity['id'])
          vm_opportunity.update_event(opportunity)
          vm_opportunity.save

          event = Event.find_or_initialize_by_vm_id(vm_opportunity.id)
          event.name = vm_opportunity.title
          event.description = vm_opportunity.description
          event.start = vm_opportunity.start_time
          event.end = vm_opportunity.end_time
          event.hosted_by = vm_opportunity.contact_name
          event.website = vm_opportunity.vm_url
          event.special_instructions = [vm_opportunity.skills_needed, vm_opportunity.requirements].join("\r\n")
          event.street = vm_opportunity.street
          event.neighborhood = vm_opportunity.neighborhood
          event.latitude = vm_opportunity.latitude
          event.longitude = vm_opportunity.longitude
          event.zip = vm_opportunity.zip
          event.user = User.first
          event.save

          vm_opportunity.imported = true
          vm_opportunity.save
        end
      end
    end
  end

  def update_event(json=nil)
    if vm_id == nil
      raise
    end

    if json == nil
      response = VolunteerMatch.search_opportunities({fieldsToDisplay:
                                                          [:allowGroupInvitations, :allowGroupReservation,
                                                           :availability, :beneficiary, :categoryIds, :contact,
                                                           :created, :currentPage, :description, :greatFor,
                                                           :hasWaitList, :id, :imageUrl, :location, :minimumAge,
                                                           :numReferred, :parentOrg, :plaintextDescription,
                                                           :plaintextRequirements, :plaintextSkillsNeeded,
                                                           :referralFields, :requirements, :requirementsMap,
                                                           :requiresAddress, :resultsSize, :skillsList,
                                                           :skillsNeeded, :spacesAvailable, :status, :tags,
                                                           :title, :type, :updated, :virtual, :vmUrl,
                                                           :volunteersNeeded],
                                                      ids: [vm_id]})
      json = response.opportunities[0]
    end
    Rails.logger.debug 'JSON'
    Rails.logger.debug json.inspect

    self.allow_group_invitations = json['allowGroupInvitations']
    self.allow_group_reservation = json['allowGroupReservation']
    self.created = json['created']
    self.description = json['plaintextDescription']
    self.great_for = json['greatFor']
    self.contact_email = json['contact']['email']
    self.contact_name = (json['contact']['firstName']||'') + ' ' + (json['contact']['lastName']||'')
    self.contact_phone = json['contact']['phone']
    self.has_wait_list = json['hasWaitList']
    self.minimum_age = json['minimumAge']
    self.num_referred = json['num_referred']
    self.requires_address = json['requiresAddress']
    self.requirements = json['plaintextRequirements']
    self.skills_needed = json['plaintextSkillsNeeded']
    self.spaces_available = json['spaces_available']
    self.status = json['status']
    self.tags = json['tags']
    self.title = json['title']
    self.virtual = json['virtual']
    self.vm_url = URI.unescape(json['vmUrl'])
    self.volunteers_needed = json['volunteersNeeded']

    Rails.logger.debug("#{json['availability']['startDate']} #{json['availability']['startTime'] || '08:00:00'}")


    self.start_time = ActiveSupport::TimeZone['Pacific Time (US & Canada)'].parse "#{json['availability']['startDate']} #{json['availability']['startTime'] || '08:00:00'}"
    self.end_time = ActiveSupport::TimeZone['Pacific Time (US & Canada)'].parse "#{json['availability']['endDate']} #{json['availability']['endTime'] || '20:00:00'}"


    self.street = "#{(json['location']['street1'] || '')} #{(json['location']['street2'] || '')} #{(json['location']['street3'] || '')}"

    self.city = json['location']['city']
    self.state = json['location']['region']
    self.zip = json['location']['postalCode']

    address = "#{street} #{city}, #{state} #{zip}"
    Rails.logger.debug("Address #{address}")

    if json['location']['geoLocation']
      self.latitude = json['location']['geoLocation']['latitude']
      self.longitude = json['location']['geoLocation']['longitude']
    end
    reverse_geocode

    self.neighborhood_string ||= city
  end

  def parse_address
    "#{street} #{city}, #{state} #{zip}"
  end

  def neighborhood
    Neighborhood.find_by_name(self.neighborhood_string)
  end

  def reverse_geocode
    unless self.reverse_geocoded
      self.geocoder_result = Geocoder.search(self.parse_address)[0]
      if self.geocoder_result && self.geocoder_result.address_components_of_type(:neighborhood).count > 0
        self.neighborhood_string = self.geocoder_result.address_components_of_type(:neighborhood)[0]['long_name']
      end
      self.reverse_geocoded = true
    end
  end

  def self.hello_world(name)
    call :helloWorld, {name: name}.to_json
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

  def self.create_or_update_user(user_id)
    user = User.find(user_id)

    query = {
        members: [
            {
                firstName: user.name,
                email: user.email,
                password: user.encrypted_password,
                acceptsTermsOfUse: true,
                location: {},
                authentication: VolunteerMatch.authentication_query(user.email, user.encrypted_password)
            }
        ]
    }

    Rails.logger.debug(query)
    VolunteerMatch.create_or_update_members(query)

    user.email
  end

  def self.create_or_update_members(query)
    call :createOrUpdateMembers, query.to_json, :post
  end

  def self.sign_up_for_opportunity(member_id, opportunity_id)
    self.create_or_update_referrals({oppId: opportunity_id, referrals: [member: {primaryKey: member_id}, commitmentStartDate: '2013-01-01', commitmentEndDate: '2013-12-31']})
  end

  def self.create_or_update_referrals(query)
    call :createOrUpdateReferrals, query.to_json, :post
  end

  def self.authentication_query(primary_key, password)
    nonce           = Digest::SHA2.hexdigest(rand.to_s)[0, 20]
    creation_time   = Time.now.utc.strftime('%Y-%m-%dT%H:%M:%S%z')
    password_digest = Base64.encode64(Digest::SHA2.digest(nonce + creation_time + password)).chomp
    {primary_key: primary_key, nonce: nonce, creation_time: creation_time, password_digest: password_digest}
  end

  protected

  def self.api_key
    ENV['VM_API_KEY']
  end

  def self.account_name
    ENV['VM_API_SECRET']
  end

  def self.endpoint
    ENV['VM_API_ENDPOINT']
  end

  def self.call(action, json_query, method=nil)
    nonce           = Digest::SHA2.hexdigest(rand.to_s)[0, 20]
    creation_time   = Time.now.utc.strftime('%Y-%m-%dT%H:%M:%S%z')
    password_digest = Base64.encode64(Digest::SHA2.digest(nonce + creation_time + api_key)).chomp
    endpoint        = self.endpoint
    url_s           = "http://#{endpoint}/api/call?action=#{action.to_s}"
    url_s           = json_query != nil ? "#{url_s}&query=#{URI.encode(json_query)}" : url_s
    url             = URI.parse(url_s)

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

    res = Net::HTTP.new(url.host, url.port).start { |http| http.request(req) }
    raise "HTTP error code #{res.code} body #{res.body} headers #{res.to_hash.inspect}" unless res.code == '200'
    OpenStruct.new(JSON.parse res.body)
  end
end