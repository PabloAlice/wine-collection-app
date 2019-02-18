class CreateWines < ActiveRecord::Migration[5.2]
  def change
    create_table :wines do |t|
      t.string :name
      t.string :strain
      t.integer :harvest
      t.references :cellar, foreign_key: true

      t.timestamps
    end
  end
end
