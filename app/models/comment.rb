class Comment < ActiveRecord::Base
  validates_presence_of :body
  belongs_to :story
end
