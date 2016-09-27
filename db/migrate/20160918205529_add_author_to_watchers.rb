class AddAuthorToWatchers < ActiveRecord::Migration[5.0]
  def change
    add_reference :watchers, :author, foreign_key: true
  end
end
