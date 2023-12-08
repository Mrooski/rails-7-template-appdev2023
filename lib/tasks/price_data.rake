task(:sample_prices => :environment) do

  require 'uri'
  require 'net/http'
  require 'json'

  Asset.where({:price_in_usd => nil}).each do |asset|

    ticker = asset.ticker

    url = URI("https://alpha-vantage.p.rapidapi.com/query?function=TIME_SERIES_DAILY&symbol=#{ticker}&outputsize=compact&datatype=json")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = ENV.fetch("ASSETS_KEY")
    request["X-RapidAPI-Host"] = 'alpha-vantage.p.rapidapi.com'

    response = http.request(request)
    #puts response.read_body

    #response = File.read(Dir.pwd + "/lib/tasks/API_call")

    parsed = JSON.parse(response.read_body)

    asset.price_in_usd = parsed.fetch("Time Series (Daily)").fetch("2023-12-07").fetch("4. close").to_f
    asset.save
  
    #need to spread out the requests to aviod overloading the API
    sleep(12)

  end
end
