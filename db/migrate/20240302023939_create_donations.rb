class CreateDonations < ActiveRecord::Migration[7.1]
  def change
    create_table :donations do |t|
      t.decimal :amount
      t.date :date
      t.references :institution, null: false, foreign_key: true

      t.timestamps
    end
  end
end
