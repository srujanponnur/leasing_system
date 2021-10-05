class AddPropertyFeatureKeyToProperties < ActiveRecord::Migration[6.1]
  def change
    add_reference :properties, :property_feature, null: true , foreign_key: true
  end
end
