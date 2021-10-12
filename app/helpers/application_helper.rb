module ApplicationHelper
  def fa_icon(name, style: :fas)
    tag.i nil, class: "#{style} fa-#{name}"
  end
end
