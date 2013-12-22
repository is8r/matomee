module ApplicationHelper
  
  def link_to_site_id(id)
    html = ""
    site = Site.where(id: id).first
    if site
      url = main_app.sites_path + "/" + site.id.to_s
      html = '<a href="'+url+'">'+site.name+'</a>'
    end
    raw html
  end
end
