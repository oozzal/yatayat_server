class AddLocationIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :location_id, :integer, index: true
  end
end

