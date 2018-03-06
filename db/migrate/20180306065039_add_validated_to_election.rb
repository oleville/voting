class AddValidatedToElection < ActiveRecord::Migration[5.1]
  def change
    add_column :elections, :validated, :boolean
  end
end
