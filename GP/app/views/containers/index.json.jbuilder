json.array!(@containers) do |container|
  json.extract! container, :id, :width, :height, :serialNo, :capacity, :price, :total_power
  json.url container_url(container, format: :json)
end
