class CreateApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :applications do |t|
      t.string :application_id
      t.string :status

      t.timestamps
    end
    add_index :applications, :application_id, unique: true
  end
end
