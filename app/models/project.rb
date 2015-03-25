class Project < ActiveRecord::Base
	has_one :image, as: :imageable
	has_many :positions
	belongs_to :owner, class_name: 'User'
	has_many :position_requests, through: :positions

	validates :name, presence: true
	validates :description, presence: true
	validates :status, presence: true
	validates :location, presence: true

  accepts_nested_attributes_for :positions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :image

  paginates_per 6

  def profile_picture(*file_size)
    if (self.image == nil)
      if file_size.empty?
        "/fallback/project_picture.jpg"
      else
        "/fallback/" + [file_size, "project_picture.jpg"].compact.join('_')
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



