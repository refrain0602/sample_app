class UsersController < ApplicationController
  def show
  
  	@user = User.find( params[:id] )
  
  end
  
  def new
  
  	@user = User.new
  
  end
  
  def create
  
  	@user = User.new( user_params )
  	
  	if @user.save
  		# ログイン処理を行う
  		sign_in @user
  		
  		# 保存成功時の処理
  		flash[:success] = "Welcome to the Sample App!"
  		
  		redirect_to @user
  	else
  		render "new"
  	end
  	
  end
  
	# 内部処理群
	private
  
		def user_params
			params.require( :user ).permit( :name, :email, :password, :password_confirmation )
		end
  
end
