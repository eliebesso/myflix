class GenerateTokenForExistingUsers < ActiveRecord::Migration
  def change
  	User.all.each do |user|
  		user.udpate_column(:token, SecureRandom.urlsafe_base64)
  	end
  end
end
