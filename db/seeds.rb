#
# Languages
#

Language.delete_all

{ :ar => "Arabic",
  :bg => "Bulgarian",
  :cs => "Czech",
  :da => "Danish",
  :de => "German",
  :el => "Greek",
  :en => "English",
  :es => "Spanish",
  :fi => "Finnish",
  :fr => "French",
  :hu => "Hungarian",
  :it => "Italian",
  :ja => "Japanese",
  :ko => "Korean",
  :nl => "Dutch",
  :no => "Norwegian",
  :pl => "Polish",
  :pt => "Portuguese",
  :ro => "Romanian",
  :ru => "Russian",
  :sv => "Swedish",
  :tr => "Turkish",
  :vi => "Vietnamese",
  :zh => "Chinese" }.each do |iso_code, name|
    Language.create!(iso_code: iso_code, name: name)
  end

#
# Projects
#

LANGUAGES = %w{en es de}

Project.delete_all
TextResource.delete_all
TextResourceTranslation.delete_all

%w{Devise Rails-I18n}.each do |name|
  project = Project.create! do |project|
    project.name = name
    project.master_language = "en"
    project.languages = LANGUAGES
  end

  name = name.downcase

  LANGUAGES.each do |language|
    file = Rails.root.join("db/seeds/#{name}/#{language}.yml")
    TextResourceImporter.import_yaml_file_into_project(file, project, :language => language)
  end
end
