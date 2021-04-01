class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.text :name
      t.integer :stars
      t.text :comment
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
