class AddFirstPostApprovedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :Users, :first_post_approved, :boolean, default: false
  end
end
