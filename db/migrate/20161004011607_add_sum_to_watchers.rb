class AddSumToWatchers < ActiveRecord::Migration[5.0]
  def change
    add_column :watchers, :sum, :integer
  end
end
