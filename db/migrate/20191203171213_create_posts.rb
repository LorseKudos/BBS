class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name
      t.text :body
      t.references :topic, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
