class CreateLeasingAgents < ActiveRecord::Migration[6.1]
  def change
    create_table :leasing_agents do |t|
      t.string :password_digest
      t.string :name
      t.string :phone_number

      t.timestamps
    end
  end
end
