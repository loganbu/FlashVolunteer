module EventsHelper
  def twitter_url(event)
    "http://twitter.com/home?source=" + root_url + "&status=Thinking%20about%20volunteering%20at%20" + event_url(event) + "%20via%20@flashvolunteer.%20Anyone%20want%20to%20join?"
  end
  def facebook_url(event)
    "http://www.facebook.com/sharer.php?u=" + event_url(event)
  end
end
