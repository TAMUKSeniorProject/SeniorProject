class AddStartTimeToDiscussions < ActiveRecord::Migration[5.0]
  def change
    add_column :discussions, :start_time, :datetime
  end
end
