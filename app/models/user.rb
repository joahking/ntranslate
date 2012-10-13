class User < ActiveRecord::Base
  has_many :identities, :dependent => :destroy
  has_many :user_projects, :dependent => :destroy
  has_many :projects, :through => :user_projects

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :avatar

  validates_presence_of :role, :in => %w{admin developer translator}

  before_validation :set_default_role

  def self.create_from_hash!(auth_hash)
    create!(:name   => auth_hash['info']['name'],
            :email  => auth_hash['info']['email'],
            :avatar => auth_hash['info']['image'])
  end

private

  def set_default_role
    self.role ||= "translator"
  end
end
