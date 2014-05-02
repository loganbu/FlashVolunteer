module EventsHelper
  def bitly_url(long_url)
    bitly = Bitly.new(ENV['BITLY_USERNAME'], ENV['BITLY_APIKEY']) 
    page_url = bitly.shorten(long_url) 
    return page_url.short_url
  end
  def twitter_url(event)
    "http://twitter.com/home?source=#{root_url}&status=Thinking%20about%20volunteering%20at%20#{bitly_url(event_url(event))}%20via%20@flashvolunteer.%20Anyone%20want%20to%20join?#{u(event.twitter_hashtags)}#{u(' #volkc')}"
  end
  def facebook_url(event)
    "http://www.facebook.com/sharer.php?u=#{bitly_url(event_url(event))}&t=#{u(event.name)}"
  end
end
