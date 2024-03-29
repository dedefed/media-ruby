class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string "username", :null => false
      t.string "firstname", :null => false
      t.string "lastname", :null => false
      t.string "password", :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
