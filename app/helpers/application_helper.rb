module ApplicationHelper

  def nav_bar_current?(page)
    select = (@select_override.present?) ? @select_override : request.fullpath.split("?")[0]
    page == select ? 'active' : ''
  end
end
