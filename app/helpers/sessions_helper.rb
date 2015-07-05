module SessionsHelper

	def sign_in( user )
		
		# トークンの新規作成
		remember_token = User.new_remember_token
		
		# 暗号化されていないトークンをCookieに設定
		# 自動的に期限を省略すると20年と設定される(永続化)
		cookies.permanent[:remember_token] = remember_token
		
		# 暗号化したトークンをDBに保存
		user.update_attribute( :remember_token, User.encrypt( remember_token ) )
		
		# 更新したトークン情報を持つユーザ情報を保持
		self.current_user = user
		
	end
	
	
	def signed_in?
	
		! current_user.nil?
	
	end


	def current_user=( user )
	
		# パラメータの情報をログインユーザ情報として保持
		@current_user = user
	
	end

	def current_user
	
		# Cookieにあるトークンを取得し暗号化してみる
		remember_token = User.encrypt( cookies[:remember_token] )
		
		# 暗号化されたトークンからユーザ情報を取得しログインユーザ情報に保持する
		# (但し、ログイン情報が無い場合のみとする (or equals) )
		@current_user ||= User.find_by( remember_token: remember_token )
	
	end

end
