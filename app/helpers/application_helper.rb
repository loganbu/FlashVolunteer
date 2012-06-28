module ApplicationHelper

def photo_link(entity, image, url)
    link_to url do
        image_tag entity.url(image), :class=>"photo-#{image}"
    end 
end

def new_event_link
    if !user_signed_in?
        "<p>You need to #{link_to('sign in', new_user_session_url)} to create an event.</p>".html_safe
    elsif can? :create, Event
    	"<p>#{link_to "Create new event", new_event_url}</p>".html_safe
    else
    	"<p>You need to confirm your account before you can start adding events. Check your personal inbox for the confirmation email from Charlie X. Buttons.</p><p>#{link_to 'Resend the e-mail to '+current_user.email, new_user_confirmation_url+'?email='+current_user.email}</p>".html_safe
    end
end

def qr_code(url, alt="QR Code", size=120)
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
def display_text_field_mailer(text)
    text.gsub(/\n/, '<br/>').html_safe
end

end
