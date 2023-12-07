class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many  :trades_sent, class_name: "Trade", foreign_key: "sender_id", dependent: :nullify
  has_many  :trades_recieved, class_name: "Trade", foreign_key: "reciever_id", dependent: :destroy
end
