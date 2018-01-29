class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable      
  # has_many :university_users    
  has_many :campus_users
  has_many :invitations
  has_many :user_tickets
  validates :email, presence: true
  
  def update_user(options)
  		self.firstname = options[:firstname]
      self.lastname = options[:lastname]
  		self.email = options[:email]
  		self.save!
  end

  def update_social_connect(options)
    self.linkedin_link = options[:linkedin_link]
    self.facebook_link = options[:fb_link]
    self.twitter_link = options[:twitter_link]
    self.save!
  end
  def send_devise_notification(notification, *args)
       devise_mailer.delay.send(notification, self, *args)
  end
end
