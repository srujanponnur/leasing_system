class AddUnitsToProperty < ActiveRecord::Migration[6.1]
  def change
    add_column :properties, :units, :integer
  end
end
