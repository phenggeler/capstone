class AddFrequencyToWatcherAgain < ActiveRecord::Migration[5.0]
  def change
    add_column :watchers, :frequency, :string
  end
end
