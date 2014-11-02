class AddSubCategoryIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :sub_category_id, :integer
  end
end
