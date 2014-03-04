module ApplicationHelper

def photo_link(entity, image, url)
  link_to url do
    image_tag entity.url(image), :class=>"photo-#{image}"
  end
end

def friendly_name(str) 
  str.gsub(/[^\w\s_-]+/, '')
     .gsub(/(^|\b\s)\s+($|\s?\b)/, '\\1\\2')
     .gsub(/\s+/, '_')
end 

def new_event_link
  if !user_signed_in?
    "<p>You need to #{link_to('sign in', new_user_session_url)} to create an event.</p>".html_safe
  elsif can? :create, Event
    "#{link_to 'Create New Event', new_event_url}".html_safe
  else
    "<p>You need to confirm your account before you can start adding events. Check your personal inbox for the confirmation email from 'charlie@flashvolunteer.org'.</p><p>#{link_to 'Resend the e-mail to '+current_user.email, new_user_confirmation_url+'?email='+current_user.email}</p>".html_safe
  end
end

def qr_code(url, alt='QR Code', size=120)
  image_tag "//chart.apis.google.com/chart?cht=qr&chl=#{url}&chs=#{size}x#{size}", :alt => alt, :width => size, :height => size
end

def original_user_logged_in
  session[:original_user]
end

def store_original_user_logged_in(other)
  session[:original_user] = other.id
end

def display_text_field(text)
  h(text).gsub(/\n/, '<br/>').html_safe
end
def display_text_field_safe(text)
  text.gsub(/\n/, '<br/>').html_safe
end

def geocoded_location_latitude
  return request.location.latitude if request.location
  return 47.613183
end

def geocoded_location_longitude
  return request.location.longitude if request.location
  return -122.346983
end

def current_location_point
  "POINT(#{geocoded_location_longitude} #{geocoded_location_latitude})"
end

def location_to_wkb(point)
  "POINT(#{point.longitude} #{point.latitude})"
end

def current_location_name
  params[:location] || cookies['location'] || Hub.closest(current_location_point).name
end

end
