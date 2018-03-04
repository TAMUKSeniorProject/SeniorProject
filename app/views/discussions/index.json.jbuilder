json.array!(@discussions) do |discussion|
  json.extract! discussion, :id, :title, :content
  json.url discussion_url(discussion, format: :json)
end
