json.array!(@quantities) do |quantity|
  json.extract! quantity, :id, :unit_name
  json.url quantity_url(quantity, format: :json)
end
