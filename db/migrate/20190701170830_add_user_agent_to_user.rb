class AddUserAgentToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_sign_in_user_agent, :string
    add_column :users, :current_sign_in_user_agent, :string
  end
end
