class AddCustomEmailMessageToQuotations < ActiveRecord::Migration[5.2]
  def change
    add_column :quotations, :custom_email_message, :string
  end
end
