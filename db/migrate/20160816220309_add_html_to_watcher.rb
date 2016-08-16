class AddHtmlToWatcher < ActiveRecord::Migration[5.0]
  def change
    add_column :watchers, :title, :string
    add_column :watchers, :p, :string
    add_column :watchers, :h1, :string
    add_column :watchers, :h2, :string
    add_column :watchers, :h3, :string
    add_column :watchers, :link, :integer
    add_column :watchers, :description, :string
    add_column :watchers, :keywords, :string
  end
end
