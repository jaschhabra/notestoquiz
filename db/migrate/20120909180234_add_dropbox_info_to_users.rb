class AddDropboxInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dropbox_token, :string
    add_column :users, :dropbox_secret, :string
  end
end
