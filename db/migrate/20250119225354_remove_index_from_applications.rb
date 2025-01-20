class RemoveIndexFromApplications < ActiveRecord::Migration[8.0]
  def change
    remove_index :applications, name: "index_applications_on_application_name"
  end
end
