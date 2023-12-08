task(:sample_trades => :environment) do
  2000.times do
    x = Trade.new
    x.sender_id = User.where({:id => 195}).at(0).id
    x.reciever_id = User.all.sample.id
    x.asset_id = Asset.all.sample.id
    x.asset_quantity = rand(1..100)
    x.save
  end
  
end
