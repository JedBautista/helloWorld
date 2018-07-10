module PostHelper
  def render_full_name(u)
    "#{u.first_name} #{u.last_name} "
  end
end