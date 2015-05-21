json.array!(@materials) do |material|
  json.extract! material, :id, :name, :quantity, :price, :Min_Number, :stockNo, :shelfNo, :production_date, :expiration_date, :quantity_id
  json.url material_url(material, format: :json)
end
