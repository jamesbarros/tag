class User < ActiveRecord::Base
  has_many :tasks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :omniauthable, :omniauth_providers => [:facebook]

         # commenting out :stripe_connect while in integration phrase :# , :stripe_connect
         # current iteration is promissing step to lanch from

         # models/user.rb : overide Devise' method in model
           # deliver_later sending will be qued up
           def send_devise_notification(notification, *args)
             devise_mailer.send(notification, self, *args).deliver_later
           end

           # from_omniauth class method to user model
           def self.from_omniauth(auth)
             where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
               user.provider = auth.provider
               user.uid = auth.uid
               user.email = auth.info.email
               user.name = auth.info.name # populate name field
               user.password = Devise.friendly_token[0,20] # generate password for OAuth users # we don't need this as the provider manages it
             end
           end

           ## overide update_without_password
           # http://stackoverflow.com/questions/30105116/let-user-update-their-password-without-current-password-in-devise
           ## works, testing to validate

           def update_without_password(params, *options)

             if params[:password].blank?
               params.delete(:password)
               params.delete(:password_confirmation) if params[:password_confirmation].blank?
             end

             result = update_attributes(params, *options)
             clean_up_passwords
             result
           end

end
