json.array!(@neighborhoods) do |neighborhood|
  json.extract! neighborhood, :id, :name
end