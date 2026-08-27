Geocoder.configure(
  lookup: :mapbox,
  api_key: ENV.fetch("MAPBOX_ACCESS_TOKEN"),
  units: :km
)
