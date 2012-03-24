module ApplicationHelper

def photo_link(entity, image, url)
    link_to url do
        image_tag entity.url(image)
    end 
end

end
