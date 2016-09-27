class AddUrlToWatchers < ActiveRecord::Migration[5.0]
  def change
    add_column :watchers, :url, :string
  end
end
