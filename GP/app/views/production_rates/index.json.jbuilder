json.array!(@production_rates) do |production_rate|
  json.extract! production_rate, :id, :number_of_panels_per_hour
  json.url production_rate_url(production_rate, format: :json)
end
