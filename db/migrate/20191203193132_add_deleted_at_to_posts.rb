class AddDeletedAtToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :deleted_at, :datetime
  end
end
