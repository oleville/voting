class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :auth_token, limit: 2048
      t.datetime :auth_token_expiration

      t.timestamps
    end
  end
end
