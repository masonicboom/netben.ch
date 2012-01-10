Factory.define :place do |f|
  f.name 'Coffee Land'
  f.google_id '2134fe132'
  f.latitude 37.7489
  f.longitude -122.4281
end

Factory.define :bench do |f|
  f.association :place
  f.download_mbps 2.6
  f.upload_mbps 1.5
  f.loss_rate 0.04
  f.ssid 'linksys'
end
