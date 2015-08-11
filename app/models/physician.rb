class Physician < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :users, :through => :friendships  -> { where accepted: true}
  has_many :pending_users, class_name: 'User', :through => :friendships, source: :user -> { where accepted: false}
  has_many :friendships
end
