class Asset < ApplicationRecord
  has_many  :trades, class_name: "Trade", foreign_key: "asset_id", dependent: :nullify
end
