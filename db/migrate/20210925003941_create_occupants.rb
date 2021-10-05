class CreateOccupants < ActiveRecord::Migration[6.1]
  def change
    create_table :occupants do |t|

      t.timestamps
    end
  end
end
