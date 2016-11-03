class AddUserToDomains < ActiveRecord::Migration[5.0]
  def change
    add_reference :domains, :user, foreign_key: true
  end
end
