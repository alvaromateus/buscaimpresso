# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def error_messages_for(object_name, options = {})
    options = options.symbolize_keys
    object = instance_variable_get("@#{object_name}")
    unless object.errors.empty?
      items = []
      object.errors.each { |attribute, message| items << content_tag("dd", message) }
      content_tag("dl",
        content_tag("dt", "") +
        items.join(""),
        "id" => options[:id] || "error", "class" => options[:class] || "error"
      )
    end
  end

end