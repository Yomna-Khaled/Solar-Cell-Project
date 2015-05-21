json.array!(@material_vendors) do |material_vendor|
  json.extract! material_vendor, :id, :vendor_id, :material_id, :date
  json.url material_vendor_url(material_vendor, format: :json)
end
