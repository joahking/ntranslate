module ApplicationHelper
  def welcome_user
    img = if current_user.avatar
           image_tag current_user.avatar, :size => "32x32", :alt => current_user.name
         end

    "#{img} Welcome #{current_user.name}".html_safe
  end

  def humanize_locale(iso_code)
    Language.where(:iso_code => iso_code).first.name
  end

  def languages_collection(languages = Language.ordered)
    languages.map {|l| [l.name, l.iso_code]}
  end
end
