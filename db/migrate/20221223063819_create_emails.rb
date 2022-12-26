class CreateEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :emails do |t|
      t.string :title
      t.text :description
      t.string :sender
      t.string :receiver
      t.boolean :is_archived
      t.boolean :is_deleted
      t.string :groups
      t.timestamps
    end
  end
end
