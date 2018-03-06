class CreateWriteIns < ActiveRecord::Migration[5.1]
  def change
    create_table :write_ins do |t|
      t.string :name
      t.references :position, foreign_key: true
      t.references :ballot, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
