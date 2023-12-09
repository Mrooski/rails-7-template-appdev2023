class TradesController < ApplicationController
  def index

    user_id = current_user.id

    recieved_trades = Trade.where({:reciever_id => user_id})
    sent_trades = Trade.where({:sender_id => user_id})

    @list_of_trades = (recieved_trades + sent_trades)

    @asset_totals = []

    @net_value = 0

    Asset.all.each do |asset|
      
      id = asset.id
      total = 0

      @list_of_trades.each do |trade|
        if trade.asset.id == id
          if trade.reciever_id == user_id
            total = total + trade.asset_quantity.to_i
          elsif trade.sender_id == user_id
            total = total - trade.asset_quantity.to_i
          end

        end
      end

      if total > 0
        @asset_totals.push([asset.ticker, total, total*asset.price_in_usd, asset.id])
      end

    end

    @asset_totals.each do |asset|
      @net_value = @net_value + asset[2]
    end

    render({ :template => "trades/index" })
  end

  def show
    the_id = current_user.id

    matching_trades = Trade.where({ :sender_id => the_id })

    @the_trade = matching_trades.at(0)

    render({ :template => "trades/show" })
  end

  def create

    temp_asset_id = params.fetch("query_asset_id")

    total = 0

    Trade.where({:asset_id => temp_asset_id}).each do |trade|
        if trade.reciever_id == current_user.id
          total = total + trade.asset_quantity.to_i
        elsif trade.sender_id == current_user.id
          total = total - trade.asset_quantity.to_i
        end
    end


    the_trade = Trade.new
    the_trade.sender_id = current_user.id
    the_trade.reciever_id = User.where({:email => params.fetch("query_reciever_email")}).at(0).id
    the_trade.asset_id = params.fetch("query_asset_id")
    the_trade.asset_quantity = params.fetch("query_asset_quantity")

    if total <= the_trade.asset_quantity.to_i
      redirect_to("/trades", { :alert => "You don't have enough #{the_trade.asset.name}"})
    elsif the_trade.valid?
      the_trade.save
      redirect_to("/trades", { :notice => "Trade created successfully." })
    elsif
      redirect_to("/trades", { :alert => the_trade.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_trade = Trade.where({ :id => the_id }).at(0)

    the_trade.sender_id = params.fetch("query_sender_id")
    the_trade.reciever_id = params.fetch("query_reciever_id")
    the_trade.asset_id = params.fetch("query_asset_id")
    the_trade.asset_quantity = params.fetch("query_asset_quantity")

    if the_trade.valid?
      the_trade.save
      redirect_to("/trades/#{the_trade.id}", { :notice => "Trade updated successfully."} )
    else
      redirect_to("/trades/#{the_trade.id}", { :alert => the_trade.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_trade = Trade.where({ :id => the_id }).at(0)

    the_trade.destroy

    redirect_to("/trades", { :notice => "Trade deleted successfully."} )
  end
end
