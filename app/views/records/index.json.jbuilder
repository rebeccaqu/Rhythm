json.array!(@records) do |record|
  json.extract! record, :id, :name, :starts_at
  json.url record_url(record, format: :json)
end
