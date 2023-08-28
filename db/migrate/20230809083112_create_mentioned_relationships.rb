class CreateMentionedRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :mentioned_relationships do |t|
      t.belongs_to :mentioning, null: false, foreign_key: { to_table: :reports }
      t.belongs_to :mentioned, null: false, foreign_key: { to_table: :reports }

      t.timestamps
    end
    add_index :mentioned_relationships, [:mentioning_id, :mentioned_id], unique: true
  end
end
