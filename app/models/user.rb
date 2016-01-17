class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :listings, dependent: :destroy
  has_many :sales, class_name: 'Order', foreign_key: 'seller_id'
  has_many :purchases, class_name: 'Order', foreign_key: 'buyer_id'    
end
