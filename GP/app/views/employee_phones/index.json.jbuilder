json.array!(@employee_phones) do |employee_phone|
  json.extract! employee_phone, :id, :employee_id, :phone
  json.url employee_phone_url(employee_phone, format: :json)
end
