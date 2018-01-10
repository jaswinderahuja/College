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
end
