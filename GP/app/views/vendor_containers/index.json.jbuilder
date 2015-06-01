json.array!(@vendor_containers) do |vendor_container|
  json.extract! vendor_container, :id, :vendor_id, :container_id, :date
  json.url vendor_container_url(vendor_container, format: :json)
end
