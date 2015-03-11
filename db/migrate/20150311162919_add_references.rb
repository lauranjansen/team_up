class AddReferences < ActiveRecord::Migration
  def change
  	add_reference :projects, :owner, index: true

  	add_reference :positions, :project, index: true
  	add_reference :positions, :user, index: true
  	add_reference :positions, :role, index: true

  	add_reference :position_requests, :position, index: true
  	add_reference :position_requests, :user, index: true

  	add_reference :skills, :user, index: true
  end
end
