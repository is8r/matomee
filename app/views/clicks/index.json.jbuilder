json.array!(@clicks) do |click|
  json.extract! click, :count
  json.url click_url(click, format: :json)
end
