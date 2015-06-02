json.array!(@vendor_phones) do |vendor_phone|
  json.extract! vendor_phone, :id, :vendor_id, :phone
  json.url vendor_phone_url(vendor_phone, format: :json)
end
