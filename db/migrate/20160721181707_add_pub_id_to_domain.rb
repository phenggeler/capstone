class AddPubIdToDomain < ActiveRecord::Migration[5.0]
  def change
    add_column :domains, :pubid, :string
  end
end
