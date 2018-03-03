class RemovePictureUrlFromPosition < ActiveRecord::Migration[5.1]
  def change
    remove_column :positions, :picture_url, :string
  end
end
