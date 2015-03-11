class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
    	t.text	:description
    	
      t.timestamps null: false
    end
  end
end
