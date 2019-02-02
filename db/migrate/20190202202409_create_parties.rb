class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.string :title
      t.references :quotation, foreign_key: true
      t.datetime :datetime

      t.timestamps
    end
  end
end
