class AddUseToWatcher < ActiveRecord::Migration[5.0]
  def change
    add_column :watchers, :use, :string
  end
end
