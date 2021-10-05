class AddKeyToProperties < ActiveRecord::Migration[6.1]
  def change
    add_reference :properties, :applicant, null: true, foreign_key: true
  end
end
