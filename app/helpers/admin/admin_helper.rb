module Admin::AdminHelper

  def active_page?(path)
    current_page?(path) ? "active" : "inactive"
  end
end
