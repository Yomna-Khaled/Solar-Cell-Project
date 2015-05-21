json.array!(@employees) do |employee|
  json.extract! employee, :id, :first_name, :last_name, :salary, :houre_rate, :education_level, :Governamental_ID, :position, :type, :crew_id
  json.url employee_url(employee, format: :json)
end
