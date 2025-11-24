class DropAdminTables < ActiveRecord::Migration[8.0]
  def up
    drop_table :admin_users, if_exists: true
    drop_table :active_admin_comments, if_exists: true
  end

  def down
    # No need to recreate these tables
  end
end
