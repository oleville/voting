class RemovePictureUrlFromCandidate < ActiveRecord::Migration[5.1]
  def change
    remove_column :candidates, :picture_url, :string
  end
end
