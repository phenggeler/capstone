json.array!(@domains) do |domain|
  json.extract! domain, :id, :name, :uacode
  json.url domain_url(domain, format: :json)
end
