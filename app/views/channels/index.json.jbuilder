json.array!(@channels) do |channel|
  json.extract! channel, :id, :channel
  json.url channel_url(channel, format: :json)
end
