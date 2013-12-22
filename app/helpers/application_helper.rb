module ApplicationHelper
  def foo_time(datetime)
    time_ago_in_words(datetime) + '前'
  end

  def link_to_site_id(id)
    html = id.to_s
    site = Site.where(id: id).first
    if site
      url = main_app.sites_path + "/" + site.id.to_s
      html = '<a href="'+url+'">'+site.name+'</a>'
    end
    raw html
  end

end
