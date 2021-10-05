class AddKeysToLeasingAgents < ActiveRecord::Migration[6.1]
  def change
    add_reference :leasing_agents, :user, null: false, foreign_key: true
  end
end
