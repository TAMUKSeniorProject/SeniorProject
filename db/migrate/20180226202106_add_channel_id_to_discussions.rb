class AddChannelIdToDiscussions < ActiveRecord::Migration[5.0]
  def change
    add_column :discussions, :channel_id, :integer
  end
end
