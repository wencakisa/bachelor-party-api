class AddActivityForeignKeyToPrices < ActiveRecord::Migration[5.2]
  def change
    add_reference :prices, :activity, foreign_key: true
  end
end
