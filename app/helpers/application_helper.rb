module ApplicationHelper
  
  require 'parallel'
  
  # --------------------------------------------------
  # スケジューラーから実行
  def scrape_update
    Parallel.each(Site.all, in_threads: 1) {|i|
      scrape i.rss
    }
  end
  def scrape (uri)
    re = ''
    # URI.parse(uri).readが無いとエラーになるみたいなのでtry,catch
    begin
      page = URI.parse(uri).read
      doc = Nokogiri::XML(open(uri))

      doc.search('item').each do |i|
        # new
        post = Post.new
        post.title = i.search('title').text
        post.url = i.search('link').text
        post.description = i.search('description').text
        post.posted_at = Time.parse(i.xpath('dc:date').text)
        post.site_id = get_site_id_rss(uri)

        # save
        add_db_create_or_update(post)

        # re = post
      end
    rescue => ex
    end

    re
  end

  #
  def get_site_id_rss(rss)
    site = Site.where(rss: rss).first
    re = 0
    unless site.blank?
      re = site.id
    end
    re
  end

  # model?
  def add_db_create_or_update(post)
    posts = Post.where(:url => post.url).first
    if posts.blank?
      post.save
    else
      if posts.site_id.blank? || post.site_id < 1
        posts.update_attribute(:site_id, post.site_id)
      end
      if posts.posted_at.blank? || post.posted_at
        posts.update_attribute(:posted_at, post.posted_at)
      end
    end
  end
  
  # all
  def scrape_all
    sites = Site.all
    sites.each do |i|
      ApplicationController.helpers.scrape i.rss
    end
  end

  # --------------------------------------------------

  def foo_time(datetime)
    time_ago_in_words(datetime) + '前'
  end

  def links_categories()
    html = ''
    category = Category.all
    category.each do |i|
      html += '<li>'
      html += '<a href="/#/category/' + i.id.to_s + '">'
      html += i.name
      html += '</a>'
      html += '</li>'
    end
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
