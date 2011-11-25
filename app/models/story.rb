class Story < ActiveRecord::Base
  validates_presence_of :content
  validates_length_of :content, :minimum => 10
  has_many :comments, :order => 'created_at ASC', :dependent => :delete_all
end
