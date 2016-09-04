class CreateSignups < ActiveRecord::Migration[5.0]
  def change
    create_table :signups do |t|
      t.string :username
      t.string :email

      t.timestamps
    end
  end
end
