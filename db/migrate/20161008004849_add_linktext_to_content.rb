class AddLinktextToContent < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :linktext, :string
  end
end
