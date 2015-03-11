class CreateJoinTableRolesUsers < ActiveRecord::Migration
  def change
  	create_join_table :roles, :users
  end
end
