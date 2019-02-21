class ChangeUserForeignKeyForParties < ActiveRecord::Migration[5.2]
  def change
    add_reference :parties, :guide, foreign_key: { to_table: :users }
    add_reference :parties, :host, foreign_key: { to_table: :users }
  end
end
