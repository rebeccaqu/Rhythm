class Physician < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :users, through: :friendships
  has_many :friendships
  has_many :pending_users, -> { where(accepted: true) }, class_name: 'User', through: :friendships, source: :user

end

# -> { where accepted: true }
# -> { where accepted: false }