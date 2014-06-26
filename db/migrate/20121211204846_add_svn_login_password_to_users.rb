class AddSvnLoginPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :svn_login, :string
    add_column :users, :svn_password, :string
  end
end
