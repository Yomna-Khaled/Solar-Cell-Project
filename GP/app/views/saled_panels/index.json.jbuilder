json.array!(@saled_panels) do |saled_panel|
  json.extract! saled_panel, :id, :solar_panel_id, :buyer_id, :totalPrice, :totalPower
  json.url saled_panel_url(saled_panel, format: :json)
end
