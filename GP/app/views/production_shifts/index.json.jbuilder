json.array!(@production_shifts) do |production_shift|
  json.extract! production_shift, :id, :material_id, :shift_id, :material_quantity
  json.url production_shift_url(production_shift, format: :json)
end
