class RemoveContentAttributesFromWatcher < ActiveRecord::Migration[5.0]
  def change
    remove_column :watchers, :source
    remove_column :watchers, :title
    remove_column :watchers, :p
    remove_column :watchers, :h1
    remove_column :watchers, :h2
    remove_column :watchers, :h3
    remove_column :watchers, :link
    remove_column :watchers, :description
    remove_column :watchers, :keywords
    remove_column :watchers, :linktext
    remove_column :watchers, :use
    remove_column :watchers, :frequency
    remove_column :watchers, :lastscanned
    remove_column :watchers, :sum
  end
end
