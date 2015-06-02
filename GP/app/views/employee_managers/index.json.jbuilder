json.array!(@employee_managers) do |employee_manager|
  json.extract! employee_manager, :id, :employee_id, :crew_id, :start_date, :end_date
  json.url employee_manager_url(employee_manager, format: :json)
end
