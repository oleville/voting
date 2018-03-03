class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :rank
      t.references :candidate, foreign_key: true
      t.references :user, foreign_key: true
      t.references :ballot, foreign_key: true
      t.references :position, foreign_key: true

      t.timestamps
    end
  end
end
