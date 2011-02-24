class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.text :content
      t.string :author
      t.boolean :aprooved
      t.integer :rate

      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
