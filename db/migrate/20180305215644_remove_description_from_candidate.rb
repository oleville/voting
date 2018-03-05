class RemoveDescriptionFromCandidate < ActiveRecord::Migration[5.1]
  def change
    remove_column :candidates, :description, :text
  end
end
