class AddPasswordDigestToDonors < ActiveRecord::Migration[7.1]
  def change
    add_column :donors, :password_digest, :string
  end
end
