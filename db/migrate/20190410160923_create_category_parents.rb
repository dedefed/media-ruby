class CreateCategoryParents < ActiveRecord::Migration[5.2]
  def change
    create_table :category_parents do |t|
    end
    add_reference :category_parents, :category, index: true, foreign_key: true
    rename_column :category_parents, :category_id, :parent_id
    add_column :category_parents, :child_id, :integer
  end
end
