class AddRankToWriteIn < ActiveRecord::Migration[5.1]
  def change
    add_column :write_ins, :rank, :integer
  end
end
