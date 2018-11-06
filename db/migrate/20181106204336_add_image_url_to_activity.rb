class AddImageUrlToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :image_url, :string
  end
end
