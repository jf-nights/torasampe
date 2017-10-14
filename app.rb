class Petora < Sinatra::Base
  get '/' do
    @data = '["aa",3,2]'
    erb :index
  end
end
