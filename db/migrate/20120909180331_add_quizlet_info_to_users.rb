class AddQuizletInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :quizlet_token, :string
    add_column :users, :quizlet_secret, :string
  end
end
