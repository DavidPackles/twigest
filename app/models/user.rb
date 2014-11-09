class User < ActiveRecord::Base

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:twitter]

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.from_omniauth(auth)

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|

      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified

      user.name = auth.info.name
      user.email = email ? email : "#{auth.uid}@twitter.com"
      user.password = Devise.friendly_token[0,20]
      user.image = auth.info.image

      user.token = auth.credentials.token
      user.secret = auth.credentials.secret

      user.save!

    end

  end

end

