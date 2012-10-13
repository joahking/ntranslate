module ApplicationHelper
  def welcome_user
    img = if current_user.avatar
            image_tag current_user.avatar, :size => "32x32", :alt => current_user.name
          end
    "Welcome #{img} #{current_user.name}".html_safe
  end
end
