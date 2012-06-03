module ApplicationHelper

def photo_link(entity, image, url)
    link_to url do
        image_tag entity.url(image), :class=>"photo-#{image}"
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

end
