json.array!(@crews) do |crew|
  json.extract! crew, :id, :no_of_workers
  json.url crew_url(crew, format: :json)
end
