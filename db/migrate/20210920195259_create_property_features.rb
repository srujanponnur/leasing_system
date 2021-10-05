class CreatePropertyFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :property_features do |t|
      t.boolean :are_pets_allowed
      t.boolean :in_unit_laundry
      t.boolean :parking

      t.timestamps
    end
  end
end
