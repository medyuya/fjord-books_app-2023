class CreateMentionedRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :mentioned_relationships do |t|
      t.integer :mentioning_id, null: false, foreign_key: true
      t.integer :mentioned_id, null: false, foreign_key: true

      t.timestamps
    end
    add_index :mentioned_relationships, [:mentioning_id, :mentioned_id], unique: true
  end
end
