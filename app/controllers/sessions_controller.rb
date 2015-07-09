class SessionsController < ApplicationController

	def new
	
	end
	
	# form_for版
#	def create
#	
#		user = User.find_by( email: params[:session][:email].downcase )
#		
#		if		user \
#			&&	user.authenticate( params[:session][:password] )
#			
#			# ユーザをサインインさせ、ユーザページ(show)にリダイレクトする
#			sign_in user
#			
#			redirect_to user
#	
#		else
#		
#			# エラーメッセージを表示し、サインインフォームを再描画する
#			flash.now[:error] = 'Invalid email/password conbination'
#			
#			render 'new'
#		end
#	
#	end

	# form_tag版
	def create
	
		user = User.find_by( email: params[:email].downcase )
		
		if	user && user.authenticate( params[:password] )
		
			sign_in user
			
			# 通常のリダイレクトではなくフレンドリーフォーワードを行う
			redirect_back_or user
		
		else
		
			flash.now[:error] = 'Invalid email/password conbination'
		
			render 'new'
		
		end
	
	end

	
	
	def destroy
		# ログアウトしてトップページに遷移
		sign_out
		
		redirect_to root_url
	end

end
