json.array!(@shifts) do |shift|
  json.extract! shift, :id, :employee_id, :crew_id, :start_shift_date, :end_shift_date, :start_shift_time, :end_shift_time, :production_rate
  json.url shift_url(shift, format: :json)
end
