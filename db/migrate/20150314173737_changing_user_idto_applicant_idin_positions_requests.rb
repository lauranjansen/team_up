class ChangingUserIdtoApplicantIdinPositionsRequests < ActiveRecord::Migration
  def change
    rename_column :position_requests, :user_id, :applicant_id
  end
end
