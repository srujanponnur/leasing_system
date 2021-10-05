class RemoveFieldNameFromApplicant < ActiveRecord::Migration[6.1]
  def change
    remove_column :applicants, :application_id, :string
  end
end
