class AddCompoundIndexToPostsSubs < ActiveRecord::Migration
  def change
    add_index :posts_subs, [:post_id, :sub_id], unique: true
  end
end
