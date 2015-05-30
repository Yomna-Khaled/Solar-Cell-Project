json.array!(@lookup_prices) do |lookup_price|
  json.extract! lookup_price, :id, :name, :value
  json.url lookup_price_url(lookup_price, format: :json)
end
