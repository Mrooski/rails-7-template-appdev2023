task(:sample_stocks => :environment) do
  
  #the 50 highest volume stocks as of 12/27
  list = File.read(Dir.pwd + "/lib/tasks/assets.txt")
  list.split("\n").each do |stock|
    x = Asset.new
    x.ticker = stock.split(",")[0]
    x.name = stock.split(",")[1]
    x.save
  end


  # Below was for users
  # 200.times do
  #   x = User.new
  #   x.username = Faker::Name.first_name
  #   x.email = "#{x.username}@example.com"
  #   x.password = "password"
  #   x.save
  # end
  
end
