task(:sample_users => :environment) do
  200.times do
    x = User.new
    x.username = Faker::Name.first_name
    x.email = "#{x.username}@example.com"
    x.password = "password"
    x.save
  end
  
end
