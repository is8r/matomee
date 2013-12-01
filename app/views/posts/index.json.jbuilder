json.array!(@posts) do |post|
  json.extract! post, :title, :description, :url, :thumb, :remove_thumb, :thumb_cache
  json.url post_url(post, format: :json)
end
