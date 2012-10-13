#
# Users
#

User.delete_all

#
# Languages
#

Language.delete_all

{ :aa => "Afar",
  :ab => "Abkhazian",
  :af => "Afrikaans",
  :am => "Amharic",
  :ar => "Arabic",
  :as => "Assamese",
  :ay => "Aymara",
  :az => "Azerbaijani",
  :ba => "Bashkir",
  :be => "Byelorussian",
  :bg => "Bulgarian",
  :bh => "Bihari",
  :bi => "Bislama",
  :bn => "Bengali",
  :bo => "Tibetan",
  :br => "Breton",
  :ca => "Catalan",
  :co => "Corsican",
  :cs => "Czech",
  :cy => "Welch",
  :da => "Danish",
  :de => "German",
  :dz => "Bhutani",
  :el => "Greek",
  :en => "English",
  :eo => "Esperanto",
  :es => "Spanish",
  :et => "Estonian",
  :eu => "Basque",
  :fa => "Persian",
  :fi => "Finnish",
  :fj => "Fiji",
  :fo => "Faeroese",
  :fr => "French",
  :fy => "Frisian",
  :ga => "Irish",
  :gd => "Scots Gaelic",
  :gl => "Galician",
  :gn => "Guarani",
  :gu => "Gujarati",
  :ha => "Hausa",
  :hi => "Hindi",
  :he => "Hebrew",
  :hr => "Croatian",
  :hu => "Hungarian",
  :hy => "Armenian",
  :ia => "Interlingua",
  :id => "Indonesian",
  :ie => "Interlingue",
  :ik => "Inupiak",
  :in => "former Indonesian",
  :is => "Icelandic",
  :it => "Italian",
  :iu => "Inuktitut (Eskimo)",
  :iw => "former Hebrew",
  :ja => "Japanese",
  :ji => "former Yiddish",
  :jw => "Javanese",
  :ka => "Georgian",
  :kk => "Kazakh",
  :kl => "Greenlandic",
  :km => "Cambodian",
  :kn => "Kannada",
  :ko => "Korean",
  :ks => "Kashmiri",
  :ku => "Kurdish",
  :ky => "Kirghiz",
  :la => "Latin",
  :ln => "Lingala",
  :lo => "Laothian",
  :lt => "Lithuanian",
  :lv => "Latvian, Lettish",
  :mg => "Malagasy",
  :mi => "Maori",
  :mk => "Macedonian",
  :ml => "Malayalam",
  :mn => "Mongolian",
  :mo => "Moldavian",
  :mr => "Marathi",
  :ms => "Malay",
  :mt => "Maltese",
  :my => "Burmese",
  :na => "Nauru",
  :ne => "Nepali",
  :nl => "Dutch",
  :no => "Norwegian",
  :oc => "Occitan",
  :om => "(Afan) Oromo",
  :or => "Oriya",
  :pa => "Punjabi",
  :pl => "Polish",
  :ps => "Pashto, Pushto",
  :pt => "Portuguese",
  :qu => "Quechua",
  :rm => "Rhaeto-Romance",
  :rn => "Kirundi",
  :ro => "Romanian",
  :ru => "Russian",
  :rw => "Kinyarwanda",
  :sa => "Sanskrit",
  :sd => "Sindhi",
  :sg => "Sangro",
  :sh => "Serbo-Croatian",
  :si => "Singhalese",
  :sk => "Slovak",
  :sl => "Slovenian",
  :sm => "Samoan",
  :sn => "Shona",
  :so => "Somali",
  :sq => "Albanian",
  :sr => "Serbian",
  :ss => "Siswati",
  :st => "Sesotho",
  :su => "Sudanese",
  :sv => "Swedish",
  :sw => "Swahili",
  :ta => "Tamil",
  :te => "Tegulu",
  :tg => "Tajik",
  :th => "Thai",
  :ti => "Tigrinya",
  :tk => "Turkmen",
  :tl => "Tagalog",
  :tn => "Setswana",
  :to => "Tonga",
  :tr => "Turkish",
  :ts => "Tsonga",
  :tt => "Tatar",
  :tw => "Twi",
  :ug => "Uigur",
  :uk => "Ukrainian",
  :ur => "Urdu",
  :uz => "Uzbek",
  :vi => "Vietnamese",
  :vo => "Volapuk",
  :wo => "Wolof",
  :xh => "Xhosa",
  :yi => "Yiddish",
  :yo => "Yoruba",
  :za => "Zhuang",
  :zh => "Chinese",
  :zu => "Zulu" }.each do |iso_code, name|
    Language.create!(iso_code: iso_code, name: name)
  end

#
# Projects
#

LANGUAGES = %w{en es de}

Project.delete_all

project = Project.create! do |project|
  project.name = "Devise"
  project.master_language = "en"
  project.languages = LANGUAGES
end

#
# Text Resources / Translations
#

TextResource.delete_all
Translation.delete_all

module Foo
  def self.get_names(hash={}, options={})
    options[:names] ||= {}

    hash.each do |k,v|
      prefix = options[:prefix] ? [options[:prefix], k].join(".") : k

      if v.kind_of? Hash
        get_names v, options.merge(:prefix => prefix)
      else
        options[:names][prefix] = v
      end
    end

    options[:names]
  end
end

LANGUAGES.each do |language|
  text_resources = Foo.get_names(YAML.load_file(Rails.root.join("db/seeds/#{language}.yml"))[language])

  text_resources.each do |k, v|
    tr = TextResource.find_or_initialize_by_key_and_project_id(k, project.id)
    tr.translations.build(content: v, language: language)
    tr.save!
  end
end
