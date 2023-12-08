# == Schema Information
#
# Table name: assets
#
#  id           :integer          not null, primary key
#  price_in_usd :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Asset < ApplicationRecord
  has_many  :trades, class_name: "Trade", foreign_key: "asset_id", dependent: :nullify
end
