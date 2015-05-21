json.array!(@production_shifts) do |production_shift|
  json.extract! production_shift, :id, :material_id, :crew_id, :solar_panel_id, :start_shift, :end_shift
  json.url production_shift_url(production_shift, format: :json)
end
