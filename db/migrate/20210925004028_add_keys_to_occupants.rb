class AddKeysToOccupants < ActiveRecord::Migration[6.1]
  def change
    add_reference :occupants, :property, null: false, foreign_key: true
    add_reference :occupants, :applicant, null: false, foreign_key: true
  end
end
