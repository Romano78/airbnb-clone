class CreateFlats < ActiveRecord::Migration[6.1]
  def change
    create_table :flats do |t|
      t.string :name
      t.string :address
      t.string :rating
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
