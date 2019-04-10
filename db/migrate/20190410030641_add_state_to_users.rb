class AddStateToUsers < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      ALTER TABLE users ADD state enum('active', 'inactive', 'queued', 'removed');
    SQL
    add_index :users, :state
  end

  def down
    remove_column :users, :state
  end
end
