module ApplicationHelper
  # Use the same string for <title> tag and header tag
  #
  # Usage:
  # * header in layout
  # <title><%= yield :title %></title>
  # * html in view
  # <h2><%= title "Sign Up" %></h2>
  def title(title)
    provide :title, title
    title
  end

  # for textarea
  def nl2br(str)
    h(str).gsub(/\r?\n/, '<br />').html_safe
  end
end
