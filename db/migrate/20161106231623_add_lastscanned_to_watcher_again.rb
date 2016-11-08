class AddLastscannedToWatcherAgain < ActiveRecord::Migration[5.0]
  def change
    add_column :watchers, :lastscanned, :datetime
  end
end
