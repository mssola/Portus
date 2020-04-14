# frozen_string_literal: true

module RegistriesHelper
  # Render registry status icon
  def registry_status_icon(registry)
    error = registry.reachable?
    msg   = error.empty? ? 'Reachable' : error
    time  = Time.now.getlocal.to_s(:rfc822)
    icon  = error.empty? ? 'link' : 'unlink'

    title = "#{msg} - Checked at #{time}"

    content_tag :i, '', class: "fas fa-lg fa-#{icon}", title: title
  end
end
