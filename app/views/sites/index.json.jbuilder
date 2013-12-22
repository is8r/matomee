json.array!(@sites) do |site|
  json.extract! site, :name, :url, :active
  json.url site_url(site, format: :json)
end
