json.array!(@material_theoreticals) do |material_theoretical|
  json.extract! material_theoretical, :id, :value
  json.url material_theoretical_url(material_theoretical, format: :json)
end
