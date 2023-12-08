class TradesController < ApplicationController
  def index
    matching_trades = Trade.all

    @list_of_trades = matching_trades.order({ :created_at => :desc })

    render({ :template => "trades/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_trades = Trade.where({ :id => the_id })

    @the_trade = matching_trades.at(0)

    render({ :template => "trades/show" })
  end

  def create
    the_trade = Trade.new
    the_trade.sender_id = params.fetch("query_sender_id")
    the_trade.reciever_id = params.fetch("query_reciever_id")
    the_trade.asset_id = params.fetch("query_asset_id")
    the_trade.asset_quantity = params.fetch("query_asset_quantity")

    if the_trade.valid?
      the_trade.save
      redirect_to("/trades", { :notice => "Trade created successfully." })
    else
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
