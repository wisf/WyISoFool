class Story < ActiveRecord::Base
  validates_presence_of :content
  has_many :comments, :order => 'created_at ASC', :dependent => :delete_all
end
