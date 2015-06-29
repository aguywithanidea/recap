module NotesHelper

  def labelize(str)
    klass = 'default'
    case str
    when 'action_item'
      klass = 'primary'
    when 'question'
      klass = 'warning'
    when 'concern'
      klass = 'danger'
    when 'goal'
      klass = 'success'
    end
    content_tag(:button, str.humanize.titleize, class:"btn btn-#{klass} btn-xs")
  end
end
