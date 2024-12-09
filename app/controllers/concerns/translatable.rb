module Translatable
  extend ActiveSupport::Concern

  included do
    # Ensure translations is initialized as an empty hash
    after_initialize :initialize_translations, if: :translations_nil?
  end

  def initialize_translations
    self.translations ||= {}
  end

  def translation_for(locale = I18n.locale)
    translations&.dig(locale.to_s) || "Translation not found"
  end

  def translate(attribute, locale = I18n.locale)
    translations.dig(locale.to_s, attribute.to_s) if translations[locale.to_s]
  end

  def set_translation(attribute, value, locale = I18n.locale)
    translations[locale.to_s] ||= {}
    translations[locale.to_s][attribute.to_s] = value
    save
  end

  private

  def translations_nil?
    translations.nil?
  end
end
