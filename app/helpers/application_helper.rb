module ApplicationHelper
  def welcome_user
    img = if current_user.avatar
           image_tag current_user.avatar, :size => "32x32", :alt => current_user.name
         end

    content_tag(:span, "Welcome #{current_user.name}", :class => "auth_provider") + "&nbsp".html_safe + img
  end

  def languages_collection(languages = Language.ordered)
    languages.map {|l| [l.name, l.iso_code]}
  end
end
