class AddEmailToWatcher < ActiveRecord::Migration[5.0]
  def change
    add_column :watchers, :email, :string
  end
end
