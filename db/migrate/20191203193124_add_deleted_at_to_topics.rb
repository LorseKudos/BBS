class AddDeletedAtToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :deleted_at, :datetime
  end
end
