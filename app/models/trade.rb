class Trade < ApplicationRecord
  belongs_to :asset, required: true, class_name: "Asset", foreign_key: "asset_id"
  belongs_to :sender, required: true, class_name: "User", foreign_key: "sender_id"
  belongs_to :reciever, required: true, class_name: "User", foreign_key: "reciever_id"
end
