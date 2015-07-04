class User < ActiveRecord::Base
	before_save { self.email = email.downcase }

	# name �K�{�`�F�b�N MAX 50����
	validates :name \
		,presence: true \
		,length: { maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	# email�K�{�`�F�b�N
	validates :email \
		,presence: true \
		,format: { with: VALID_EMAIL_REGEX } \
		,uniqueness: { case_sensitive: false }
end
