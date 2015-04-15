# From : https://github.com/plataformatec/devise/wiki/Override-devise_error_messages!-for-views
# modified ala : http://stackoverflow.com/questions/18780752/rails-render-partial-in-helper
module DeviseHelper
  def devise_error_messages!(message:nil,emphasis:nil)
    return "" if resource.errors.empty?

    if message.nil?
      li = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join.html_safe
      message = content_tag(:ul,li)
    end
    
    if emphasis.nil?
      emphasis = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase) 
    end
    html = render partial: '/partials/dismissable_alert', locals:{klass:'danger',emphasis:emphasis,message:message}
    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end