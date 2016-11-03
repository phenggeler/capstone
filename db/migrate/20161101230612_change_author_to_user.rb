class ChangeAuthorToUser < ActiveRecord::Migration[5.0]
  def change
    rename_table :authors, :users
  end
end
