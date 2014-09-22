json.array!(@listings) do |listing|
  json.extract! listing, :id, :address, :listing_type, :title, :description, :price, :neighborhood_id, :host_id
end