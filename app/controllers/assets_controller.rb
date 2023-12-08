class AssetsController < ApplicationController
  def index
    matching_assets = Asset.all

    @list_of_assets = matching_assets.order({ :created_at => :desc })

    render({ :template => "assets/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_assets = Asset.where({ :id => the_id })

    @the_asset = matching_assets.at(0)

    render({ :template => "assets/show" })
  end

  def create
    the_asset = Asset.new
    the_asset.price_in_usd = params.fetch("query_price_in_usd")

    if the_asset.valid?
      the_asset.save
      redirect_to("/assets", { :notice => "Asset created successfully." })
    else
      redirect_to("/assets", { :alert => the_asset.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_asset = Asset.where({ :id => the_id }).at(0)

    the_asset.price_in_usd = params.fetch("query_price_in_usd")

    if the_asset.valid?
      the_asset.save
      redirect_to("/assets/#{the_asset.id}", { :notice => "Asset updated successfully."} )
    else
      redirect_to("/assets/#{the_asset.id}", { :alert => the_asset.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_asset = Asset.where({ :id => the_id }).at(0)

    the_asset.destroy

    redirect_to("/assets", { :notice => "Asset deleted successfully."} )
  end
end
