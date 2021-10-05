class AddEmailToLeasingAgent < ActiveRecord::Migration[6.1]
  def change
    add_column :leasing_agents, :email, :string
  end
end
