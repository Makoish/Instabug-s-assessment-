class CreateApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :applications do |t|
      t.string :token
      t.string :application_name

      t.timestamps
    end
  end
end
