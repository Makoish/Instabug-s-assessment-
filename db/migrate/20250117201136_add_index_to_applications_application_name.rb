class AddIndexToApplicationsApplicationName < ActiveRecord::Migration[8.0]
  def change
    add_index :applications, :application_name
  end
end
