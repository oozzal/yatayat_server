class AddPushNotificationFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :device_registration_id, :text
    add_column :users, :notify, :boolean, default: false
    add_index :users, :notify
  end
end
