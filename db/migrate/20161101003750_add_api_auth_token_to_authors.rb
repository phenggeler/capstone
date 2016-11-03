class AddApiAuthTokenToAuthors < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :api_auth_token, :string
  end
end
