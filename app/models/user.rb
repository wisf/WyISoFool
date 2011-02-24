class User < ActiveRecord::Base
  validates_uniqueness_of :username

  def self.authenticate(username, password)
    user = User.find_by_username(username)
    if user.blank? ||
       Digest::SHA256.hexdigest(password + user.password_salt) != user.password_hash
      raise "UserName or password is invalid"
    end
    user
  end

  def password=(pass)
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    self.password_salt, self.password_hash = salt, Digest::SHA256.hexdigest(pass + salt)
  end
end
