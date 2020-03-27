class AddUniqueIndexForUserIdToApplicationTokensAndTeamUsersAndStars < ActiveRecord::Migration[6.0]
  def change
    add_index :application_tokens, [:application, :user_id], unique: true
    add_index :team_users, [:team_id, :user_id], unique: true
    add_index :stars, [:repository_id, :user_id], unique: true
  end
end
