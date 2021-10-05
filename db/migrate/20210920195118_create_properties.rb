class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :address
      t.integer :size
      t.integer :terms_available
      t.date :earliest_start_date
      t.integer :application_fee
      t.integer :monthly_rent

      t.timestamps
    end
  end
end
