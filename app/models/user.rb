class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_one :image, as: :imageable
  has_many :skills
  has_and_belongs_to_many :roles
  has_many :owned_projects, class_name: 'Project'
  has_many :position_requests
  has_many :requested_positions, through: :position_requests, class_name: 'Position'
  has_many :positions
  has_many :team_projects, through: :positions, class_name: 'Project'

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  accepts_nested_attributes_for :image
  accepts_nested_attributes_for :skills, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :roles, :reject_if => :all_blank, :allow_destroy => true

  def profile_picture(*file_size)
    if (self.image == nil)
      if file_size.empty?
        "/fallback/picture.jpg"
      else
        "/fallback/" + [file_size, "picture.jpg"].compact.join('_')
      end
    else
      if file_size.empty?
        self.image.picture
      else
        "/uploads/image/picture/#{self.image.id}/" + [file_size, "picture.jpg"].compact.join('_')
      end
    end
  end
end
