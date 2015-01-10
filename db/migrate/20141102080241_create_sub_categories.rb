class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.string :name
      t.references :category, index: true

      t.timestamps
    end
    add_index :sub_categories, :name, unique: true
  end
end
