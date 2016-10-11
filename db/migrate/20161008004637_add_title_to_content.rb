class AddTitleToContent < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :title, :string
  end
end
