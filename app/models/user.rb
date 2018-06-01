class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable
  devise :database_authenticatable, :timeoutable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:username]

  def destroy
    update_attributes(deactivated: true) unless deactivated
  end

  def active_for_authentication?
    super && !deactivated
  end
end
