class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.string :domain
      t.text :source
      t.string :p
      t.string :h1
      t.string :h2
      t.string :h3
      t.integer :link
      t.string :description
      t.string :keywords
      t.string :use
      t.string :url
      t.string :frequency
      t.integer :sum
      t.references :watcher, foreign_key: true

      t.timestamps
    end
  end
end
