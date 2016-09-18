class AddAuthorToDomains < ActiveRecord::Migration[5.0]
  def change
    add_reference :domains, :author, foreign_key: true
  end
end
