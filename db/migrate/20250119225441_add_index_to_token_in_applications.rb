class AddIndexToTokenInApplications < ActiveRecord::Migration[8.0]
  def change
    add_index :applications, :token, unique: true
  end
end
