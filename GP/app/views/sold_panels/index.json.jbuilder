json.array!(@sold_panels) do |sold_panel|
  json.extract! sold_panel, :id, :buyer_id, :totalPrice, :totalPower
  json.url sold_panel_url(sold_panel, format: :json)
end
