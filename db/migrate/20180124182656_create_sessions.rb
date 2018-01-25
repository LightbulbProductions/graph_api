class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.integer :user_id
      t.string :key
      t.text :content

      t.timestamps
    end
  end
end
