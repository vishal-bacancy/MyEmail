class CreateGroupsUsersJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :groups, :users do |t|
      t.index :group_id
      t.index :user_id
    end
  end
end
