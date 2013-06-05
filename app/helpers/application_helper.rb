module ApplicationHelper
  def cp(path)
    "active" if current_page?(path) || current_page?(root_path)
  end

  def addr2maps(addr, city)
    return "http://maps.google.com/?q=#{addr.tr ' ', '+'}+#{city.tr ' ', '+'}+Евразия"
  end
end
