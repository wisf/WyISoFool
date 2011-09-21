# encoding: UTF-8
class UserMailer < ActionMailer::Base
  default :from => "admin@pochemu-ya-takaya-dura.ru"
  def createstory_confirmation(story, user)
    @story = story
    @user = user
    mail :to => user.mail, :subject => @story.author + " added new story"
  end
  
  def newcomment_notification(comment, user)
    @comment = comment
    @user = user
    mail :to => user.mail, :subject => @comment.author + " posted new comment"
  end
end
