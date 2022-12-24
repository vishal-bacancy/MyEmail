class CreateAllEmailReceivers < ActiveRecord::Migration[7.0]
  def change
    create_table :all_email_receivers do |t|
      t.references :email, null: false, foreign_key: true
      t.integer :user_id

      t.timestamps
    end
  end
end
