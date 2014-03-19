# encoding: utf-8
unless defined?(I18nViz).nil?
  # determine under which condition the gem should be active (e.g. only in non-production environments)
  I18nViz.enabled = !Rails.env.production?

  # Link to display in the I18nViz tooltip
  # e.g. pointing to that particular string in your apps translation tool (webtranslateit.com, localeapp.com, ...)
  # the i18n key will be appended to this URL
  # I18nViz.external_tool_url = "https://webtranslateit.com/en/projects/1234567/locales/en..de/strings?utf8=✓&s="
  target_language = "pt_BR"
  I18nViz.external_tool_url = "https://www.transifex.com/projects/p/loomio-1/translate/#pt_BR/$?key="
end