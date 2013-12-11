module ApplicationHelper
  def flag_img(country_code)
    image_tag "flags/#{country_code}.png", :class => "flag-icon", :alt => country_code
  end

  def can_edit?
    !!current_user
  end
end
