module ApplicationHelper
  def flag_img(country_code)
    image_tag "flags/#{country_code}.png", :class => "flag-icon"
  end
end
