class CreatePositionRequests < ActiveRecord::Migration
  def change
    create_table :position_requests do |t|
    	t.string :status

      t.timestamps null: false
    end
  end
end
