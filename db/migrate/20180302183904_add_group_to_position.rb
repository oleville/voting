class AddGroupToPosition < ActiveRecord::Migration[5.1]
  def change
    add_reference :positions, :group, foreign_key: true
  end
end
