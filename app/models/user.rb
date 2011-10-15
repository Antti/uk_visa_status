class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  def self.find_for_google_oauth(auth_info, current_user)
    #{"provider"=>"google", "uid"=>"https://www.google.com/accounts/o8/id?id=AItOawmOCW_BrmQjXV9FvLvcWZxXIiweicENskY", "user_info"=>{"email"=>"andreydmitrenko@reevoo.com", "first_name"=>"Andrey", "last_name"=>"Dmitrenko", "name"=>"Andrey Dmitrenko"}}
    user_info = auth_info["user_info"]
    User.find_or_initialize_by_email(user_info["email"])
  end
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.google_data"] && session["devise.google_data"]["user_info"]
        user.email = data["email"]
      end
    end
  end
end
