class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.text :title
      t.text :rating
      t.decimal :total_gross

      t.timestamps
    end
  end
end
