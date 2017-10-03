Bundler.require

token = open("/home/pi/.twitter/token").read.split("\n")
client = Twitter::REST::Client.new do |c|
  c.consumer_key          = token[0]
  c.consumer_secret       = token[1]
  c.access_token          = token[2]
  c.access_token_secret   = token[3]
end

client.update("test")
