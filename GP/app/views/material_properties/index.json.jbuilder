json.array!(@material_properties) do |material_property|
  json.extract! material_property, :id, :material_id, :property_id
  json.url material_property_url(material_property, format: :json)
end
