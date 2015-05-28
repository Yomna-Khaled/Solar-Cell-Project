json.array!(@buyers) do |buyer|
  json.extract! buyer, :id, :name, :addess, :city
  json.url buyer_url(buyer, format: :json)
end
