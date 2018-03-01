class CreateCandidates < ActiveRecord::Migration[5.1]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :picture_url
      t.text :description
      t.references :election, foreign_key: true
      t.references :position, foreign_key: true

      t.timestamps
    end
  end
end
