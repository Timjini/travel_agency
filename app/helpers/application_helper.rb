module ApplicationHelper
  def locale_links
    I18n.available_locales.map do |locale|
      link_to locale.to_s.upcase, url_for(locale: locale)
    end.join(" | ").html_safe
  end
end
