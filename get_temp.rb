Bundler.require

token = open("/home/pi/.twitter/token").read.split("\n")
client = Twitter::REST::Client.new do |c|
  c.consumer_key          = token[0]
  c.consumer_secret       = token[1]
  c.access_token          = token[2]
  c.access_token_secret   = token[3]
end

# 水温計
DEVICE_ID = "28-0516a4c7a8ff"

# 温度取得
result = `cat /sys/bus/w1/devices/#{DEVICE_ID}/w1_slave`
temperature = (result.split("\s").last.gsub("t=","").to_i / 1000.0).round(2)


# ファイルに保存
# 保存するディレクトリ
Dir.mkdir("./temperature") if !File.exists?("./temperature")

# 保存するファイル
# 1日ごとにつくる
file_name = "./temperature/" + Time.now.strftime("%Y%m%d") + ".csv"
File.open(file_name).close if File.exists?(file_name)

open(file_name, "a") do |f|
  f.puts("\"#{Time.now.strftime("%H:%M")}\",#{temperature}")
end

if Time.now.min == 0
  puts msg = "#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}の水温は#{temperature}℃です"
  client.update(msg)
end
