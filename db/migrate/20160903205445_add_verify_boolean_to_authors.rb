class AddVerifyBooleanToAuthors < ActiveRecord::Migration[5.0]
  def change
    add_column :authors, :verified, :boolean
  end
end
