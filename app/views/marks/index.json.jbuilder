json.array!(@marks) do |mark|
  json.extract! mark, :id, :name
  json.url mark_url(mark, format: :json)
end
