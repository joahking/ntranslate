class User < ActiveRecord::Base
  has_many :identities, :dependent => :destroy

  #TODO add some validations! we are leaving devise ones out for now
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise # :validatable, :invitable, :database_authenticatable, :registerable, :confirmable,
         # :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :avatar

  def self.create_from_hash!(auth_hash)
    create!(:name   => auth_hash['info']['name'],
            :email  => auth_hash['info']['email'],
            :avatar => auth_hash['info']['image'])
  end
end
