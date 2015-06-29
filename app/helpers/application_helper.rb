module ApplicationHelper

  def nav_bar_current?(page)
    select = (@nav_here.present?) ? @nav_here : request.fullpath.split("?")[0]
    page == select ? 'active' : ''
  end
end
