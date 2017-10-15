class Petora < Sinatra::Base
  get '/' do
    tmp = []
    # ./temperature/%Y%m%d.csv
    today = Time.now.strftime("%Y%m%d")
    open("/home/pi/codes/torasampe/temperature/#{today}.csv").each_line do |line|
      tmp << "[" + line.chomp + "]"
    end
    @data = tmp.join(",")
    erb :index
  end
end
