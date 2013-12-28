module ApplicationHelper
  
  def foo_time(datetime)
    time_ago_in_words(datetime) + '前'
  end

  def links_categories()
    html = ''
    html += '<ul>'
    category = Category.all
    category.each do |i|
      name = i.name
      id = i.id
      html += '<li>'
      html += '<a href="#">'
      html += name
      html += '</a>'
      html += '</li>'
    end
    html += '</ul>'
    raw html
  end

  def get_category_count(id)
    html = id.to_s
    category = Site.where(category_id: id)
    category.count
  end

  def link_to_site_id_to_category(id)
    html = ''
    site = Site.where(id: id).first
    if site
      html = link_to_category_id site.id
    end
    raw html
  end

  def link_to_category_id(id)
    html = ''
    category = Category.where(id: id).first
    if category
      url = main_app.categories_path + "/" + category.id.to_s
      html = '<a href="'+url+'">'+category.name+'</a>'
    end
    raw html
  end

  def link_to_post_id(id)
    html = ''
    post = Post.where(id: id).first
    if post
      url = main_app.posts_path + "/" + post.id.to_s
      html = '<a href="'+url+'">'+post.title+'</a>'
    end
    raw html
  end

  def link_to_site_id(id)
    html = ''
    site = Site.where(id: id).first
    if site
      url = main_app.sites_path + "/" + site.id.to_s
      html = '<a href="'+url+'">'+site.name+'</a>'
    end
    raw html
  end

end
