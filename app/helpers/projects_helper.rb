module ProjectsHelper
  def link_to_translate(project, language)
    link = link_to "translate!", translations_path(project, language)
    resources_text = pluralize(project.pending_translations_count(language), "text resource")

    "#{humanize_locale(language)}: #{resources_text} to #{link}".html_safe
  end

  def random_logo(project)
    image_id = project.id % 10
    image_tag "http://lorempixel.com/200/100/nature/#{image_id}/LOGO"
  end

end
