# セキュアパスワードの適用
class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
	has_secure_password
	
	# 保存前処理
	before_save { self.email = email.downcase }
	
	# 行作成前処理
	before_create :create_remember_token

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
	

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
	
		Micropost.where( "user_id = ?", id )
	end

		private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
