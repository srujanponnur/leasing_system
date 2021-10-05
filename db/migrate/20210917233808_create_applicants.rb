class CreateApplicants < ActiveRecord::Migration[6.1]
  def change
    create_table :applicants do |t|
      t.string :applicant_id
      t.string :name
      t.string :password_digest
      t.string :email
      t.string :phone_number

      t.timestamps
    end
    add_index :applicants, :applicant_id, unique: true
  end
end
