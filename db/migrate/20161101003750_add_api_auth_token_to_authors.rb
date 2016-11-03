class AddApiAuthTokenToAuthors < ActiveRecord::Migration[5.0]
  def change
    add_column :authors, :api_auth_token, :string
  end
end
