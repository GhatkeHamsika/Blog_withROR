class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  scope :admin, -> { where(role: 'admin')}
  scope :user, -> { where(role: 'user') }


  def admin?
    role == 'admin'
  end
 
  def user?
    role == 'user'
  end

end