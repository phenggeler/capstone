class AddLinkTextToWatcher < ActiveRecord::Migration[5.0]
  def change
    add_column :watchers, :linktext, :string
  end
end
