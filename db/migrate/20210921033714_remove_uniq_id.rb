class RemoveUniqId < ActiveRecord::Migration[6.1]
  def change
    remove_column :applicants, :applicant_id, :string
    remove_column :applications, :application_id, :string
  end
end
