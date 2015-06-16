json.array!(@theoreticalcategories) do |theoreticalcategory|
  json.extract! theoreticalcategory, :id, :name
  json.url theoreticalcategory_url(theoreticalcategory, format: :json)
end
