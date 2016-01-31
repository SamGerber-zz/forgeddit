class CreatePostsSubs < ActiveRecord::Migration
  def change
    create_table :posts_subs do |t|
      t.integer :post_id, null: false
      t.integer :sub_id, null: false

      t.timestamps null: false
    end
    add_index :posts_subs, :post_id
    add_index :posts_subs, :sub_id
  end
end
