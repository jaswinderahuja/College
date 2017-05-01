module DeviseHelper
  def devise_error_messages1!
    puts "The heler method is called"
    puts "#{resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join.inspect}"
    resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
  end

  def devise_error_messages2!
    resource.errors.full_messages.map { |msg| content_tag(:p, msg) }.join
  end
end
