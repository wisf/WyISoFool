class Story < ActiveRecord::Base
  validates_presence_of :content
  has_many :comments, :order => 'created_at DESC', :dependent => :delete_all
end
