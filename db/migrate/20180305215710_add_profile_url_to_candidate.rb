class AddProfileUrlToCandidate < ActiveRecord::Migration[5.1]
  def change
    add_column :candidates, :profile_url, :string
  end
end
