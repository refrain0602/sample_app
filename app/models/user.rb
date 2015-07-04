# セキュアパスワードの適用
class User < ActiveRecord::Base
	has_secure_password
	before_save { self.email = email.downcase }

	# name 必須チェック MAX 50文字
	validates :name \
		,presence: true \
		,length: { maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+(\.[a-z]+)+*\.[a-z]+\z/i

	# email必須チェック
	validates :email \
		,presence: true \
		,format: { with: VALID_EMAIL_REGEX } \
		,uniqueness: { case_sensitive: false }
	
	# パスワード検証
	validates :password \
		,length: { minimum: 6 }
end
