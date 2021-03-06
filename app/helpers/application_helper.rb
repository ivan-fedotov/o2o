module ApplicationHelper

  def check_permissions(prm)
    raise ActionController::RoutingError.new('Not Found')  unless current_user.can?(prm) == true
  end

  def time_f(time)
    if time.nil?
      ""
    else
      time.strftime("%d.%m.%Y %H:%M")
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields button", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def get_color_by_deadline(dl, plan)
    #p "plan = #{ plan }"
    return "#FFFFFF" if dl.nil?
    diff = ((dl.to_datetime - Time.now.to_datetime) * 24).to_f
    unless plan
      #p "a - #{diff}"
      return "dl_ok" if diff > 0
      return "dl_notice" if diff > -1
      return "dl_warning" if diff > -2
      return "dl_alert"
    else
      #p "p - #{diff}"
      return "dl_ok" if diff > 0
      return "dl_notice" if diff > (-2*24)
      return "dl_warning" if diff > (-4*24)
      return "dl_alert"
    end
  end
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.permit!.merge({:sort => column, :direction => direction}), {:class => css_class}
  end

end
