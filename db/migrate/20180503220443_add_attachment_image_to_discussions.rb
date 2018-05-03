class AddAttachmentImageToDiscussions < ActiveRecord::Migration[5.0]
  def self.up
    change_table :discussions do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :discussions, :image
  end
end
