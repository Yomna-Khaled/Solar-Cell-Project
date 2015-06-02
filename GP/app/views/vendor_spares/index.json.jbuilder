json.array!(@vendor_spares) do |vendor_spare|
  json.extract! vendor_spare, :id, :date, :vendor_id, :spare_part_id
  json.url vendor_spare_url(vendor_spare, format: :json)
end
