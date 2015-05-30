json.array!(@buyer_phones) do |buyer_phone|
  json.extract! buyer_phone, :id, :buyer_id, :phone
  json.url buyer_phone_url(buyer_phone, format: :json)
end
