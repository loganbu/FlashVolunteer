class VolunteerMatchEvent < ActiveRecord::Base

  attr_accessor :geocoder_result

  scope :not_imported, lambda {
    where("imported = ?", false)
  }

  def self.update(pages_of_results, page_number=1)
    start_day = 1.week.ago
    end_day = 3.months.from_now

    (page_number..pages_of_results).each do |page|
      results = VolunteerMatch.search_opportunities({:fieldsToDisplay =>
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
                                                     :dateRanges => [{
                                                                         :startDate => start_day.strftime('%Y-%m-%d'),
                                                                         :endDate => end_day.strftime('%Y-%m-%d'),
                                                                         :singleDayOpps => true}],
                                                     :location => "Seattle, WA",
                                                     :pageNumber => page.to_i})

      results.opportunities.each do |opportunity|
        vm_opportunity = VolunteerMatchEvent.find_or_initialize_by_vm_id(opportunity['id'])
        vm_opportunity.update_event(opportunity)
        vm_opportunity.save
      end
    end
  end

  def update_event(json=nil)
    if vm_id == nil
        raise
    end

    if json == nil
        response = VolunteerMatch.search_opportunities({:fieldsToDisplay =>
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
                                                        :ids => [vm_id]})
        json = response.opportunities[0]
    end
    Rails.logger.debug "JSON"
    Rails.logger.debug json.inspect

    self.allow_group_invitations = json['allowGroupInvitations']
    self.allow_group_reservation = json['allowGroupReservation']
    self.created = json['created']
    self.description = json['description']
    self.great_for = json['greatFor']
    self.contact_email = json['contact']['email']
    self.contact_name = json['contact']['firstName'] + ' ' + json['contact']['lastName']
    self.contact_phone = json['contact']['phone']
    self.has_wait_list = json['hasWaitList']
    self.minimum_age = json['minimumAge']
    self.num_referred = json['num_referred']
    self.requires_address = json['requiresAddress']
    self.skills_needed = json['skillsNeeded']
    self.spaces_available = json['spaces_available']
    self.status = json['status']
    self.tags = json['tags']
    self.title = json['title']
    self.virtual = json['virtual']
    self.vm_url = json['vmUrl']
    self.volunteers_needed = json['volunteersNeeded']

    self.start_time = DateTime.strptime(json["availability"]["startDate"]+" "+json["availability"]["startTime"], "%Y-%m-%d %H:%M:%S")


    self.end_time = DateTime.strptime(json["availability"]["endDate"]+" "+json["availability"]["endTime"], "%Y-%m-%d %H:%M:%S")

    self.street = (json['location']['street1'] || "") + " " + (json['location']['street2'] || "") + " " + (json['location']['street3'] || "")

    self.city = json['location']['city']
    self.state = json['location']['region']
    self.zip = json['location']['postalCode']

    address = street + ' ' + city + ', ' + state + ' ' + zip
    Rails.logger.debug("Address " + address)

    if json['location']['geoLocation']
      self.latitude = json['location']['geoLocation']['latitude']
      self.longitude = json['location']['geoLocation']['longitude']
    end
    reverse_geocode
  end

  def parse_address
    street + ' ' + city + ', ' + state + ' ' + zip
  end

  def reverse_geocode
    unless self.reverse_geocoded
      self.geocoder_result = Geocoder.search(self.parse_address)[0]
      if self.geocoder_result
        if self.geocoder_result.address_components_of_type(:neighborhood).count > 0
          self.neighborhood_string = self.geocoder_result.address_components_of_type(:neighborhood)[0]['long_name']
        else
          self.neighborhood_string = nil
        end
      end
      self.reverse_geocoded = true
    end
  end
end