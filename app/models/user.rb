class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #:recoverable, :rememberable,
  devise :database_authenticatable, :registerable, :trackable, :validatable
  has_many :reviews   # usuário faz muitos reviews
  has_many :favorites # usuário favorita muitas coisas
  has_many :players   # usuário tem varios players
  validates :name, presence: true, on: :update 
          
end
