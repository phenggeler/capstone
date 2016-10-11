class AddContentToWatchers < ActiveRecord::Migration[5.0]
  def change
    add_reference :watchers, :content, foreign_key: true
  end
end
