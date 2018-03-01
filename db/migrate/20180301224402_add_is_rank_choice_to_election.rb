class AddIsRankChoiceToElection < ActiveRecord::Migration[5.1]
  def change
    add_column :elections, :is_rank_choice, :boolean
  end
end
