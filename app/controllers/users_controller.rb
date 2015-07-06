class UsersController < ApplicationController
	before_action :signed_in_user,	only: [:edit, :update]
	before_action :correct_user,	only: [:edit, :update]

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
  
  def edit
  
#  	@user = User.find( params[ :id ] )
  
  end
  
  def update
  
#  	@user = User.find( params[ :id ] )
  	
  	if @user.update_attributes( user_params )
  		# 更新に成功した場合を扱う
  		flash[:success] = "Profile updated"
  		
  		redirect_to @user
  	else
  		render 'edit'
  	end
  
  end
  
	# 内部処理群
	private
  
		def user_params
			params.require( :user ).permit( :name, :email, :password, :password_confirmation )
		end
		
		# Before actions
		
		def signed_in_user
		
			redirect_to signin_url, notice: "Please sign in." unless signed_in?
		
		end

		def correct_user
			@user = User.find(params[:id])

			redirect_to(root_path) unless current_user?(@user)
		end
end
