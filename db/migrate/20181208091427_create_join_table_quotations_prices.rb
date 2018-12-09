class CreateJoinTableQuotationsPrices < ActiveRecord::Migration[5.2]
  def change
    create_join_table :quotations, :prices do |t|
      t.index [:quotation_id, :price_id]
      # t.index [:price_id, :quotation_id]
    end
  end
end
