class AddLastGuideEmailToParties < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :last_guide_email, :string
  end
end
