class AddVkLabelToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :vk_label, :boolean
  end

  def self.down
    remove_column :stories, :vk_label
  end
end
