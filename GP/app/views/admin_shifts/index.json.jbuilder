json.array!(@admin_shifts) do |admin_shift|
  json.extract! admin_shift, :id, :power, :type, :subtype, :employee_id
  json.url admin_shift_url(admin_shift, format: :json)
end
