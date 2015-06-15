json.array!(@sales_admins) do |sales_admin|
  json.extract! sales_admin, :id, :power, :type, :subtype
  json.url sales_admin_url(sales_admin, format: :json)
end
