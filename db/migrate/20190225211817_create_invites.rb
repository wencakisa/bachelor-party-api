class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.references :invitable, polymorphic: true, index: true
      t.string :token
      t.string :email
      t.integer :status, default: 0
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
