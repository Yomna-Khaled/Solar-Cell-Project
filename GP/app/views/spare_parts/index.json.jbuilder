json.array!(@spare_parts) do |spare_part|
  json.extract! spare_part, :id, :name, :quantity, :price, :machine_id
  json.url spare_part_url(spare_part, format: :json)
end
