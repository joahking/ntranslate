module TranslationMethods
  extend ActiveSupport::Concern

  module ClassMethods
    def attr_translated(*attributes)
      attributes.each do |attr|
        Language.all.each do |language|
          locale = language.iso_code
          define_method :"#{attr}_#{locale}" do
            I18n.with_locale(locale) { self.send(attr) }
          end
          define_method :"#{attr}_#{locale}=" do |value|
            I18n.with_locale(locale) { self.send("#{attr}=", value) }
          end
          attr_accessible :"#{attr}_#{locale}"
        end
      end
    end
  end
end
