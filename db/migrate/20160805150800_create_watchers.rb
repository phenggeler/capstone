class CreateWatchers < ActiveRecord::Migration[5.0]
  def change
    create_table :watchers do |t|
      t.string :domain
      t.text :source

      t.timestamps
    end
  end
end
