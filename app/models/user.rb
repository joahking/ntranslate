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

  def refresh_projects(new_projects_ids)
    if new_projects_ids
      #removing projects not submitted
      ids_to_rm = self.project_ids - new_projects_ids.map(&:to_i)
      self.user_projects.where("project_id in (?)", ids_to_rm).map(&:destroy)

      #adding new projects submitted
      (new_projects_ids.map(&:to_i) - self.project_ids).each do |prj_id|
         self.user_projects.create :project_id => prj_id
      end
    else
      self.user_projects.destroy_all
    end
  end

private

  def set_default_role
    self.role ||= "admin"
  end
end
