class AddCategoryIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :category_id, :integer, index: true
  end
end

