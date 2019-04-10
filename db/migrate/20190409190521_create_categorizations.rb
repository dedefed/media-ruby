class CreateCategorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :categorizations do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_reference :categorizations, :article, index: true, foreign_key: true
    add_reference :categorizations, :category, index: true, foreign_key: true
  end
end
