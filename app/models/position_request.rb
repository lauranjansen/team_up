class PositionRequest < ActiveRecord::Base
	belongs_to :position
	belongs_to :applicant, class_name: "User"

  default_scope {where(status: nil)}

  scope :accepted, ->{where(status: 'accepted')}
  scope :rejected, ->{where(status: 'rejected')}

  def accept!
    transaction do
      position.update_attributes(user: applicant)
      update_attributes(status: 'accepted')
      reject_other_applicants if completely_filled?
      PositionMailer.accepted_position_mail(applicant, position.project, position.role.name).deliver_now
    end
  end

  def reject!
    update_attributes(status: 'rejected')
  end

  private
  def reject_other_applicants
    position.position_requests.each(&:reject!)
  end

  def completely_filled?
    true
  end

end
