json.array!(@solar_panels) do |solar_panel|
  json.extract! solar_panel, :id, :production_date, :expire_date, :height, :width, :power, :type, :subtype, :price, :serialNo, :container_id
  json.url solar_panel_url(solar_panel, format: :json)
end
