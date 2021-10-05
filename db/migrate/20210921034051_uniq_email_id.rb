class UniqEmailId < ActiveRecord::Migration[6.1]
  def change
    add_index :applicants, :email
    add_index :leasing_agents, :email, unique: true
    add_index :admins, :email, unique: true
  end
end
