class UsersController < ApplicationController
	before_action :signed_in_user,	only: [:index, :edit, :update, :destroy]
	before_action :correct_user,	only: [:edit, :update]
	before_action :admin_user,		only: :destroy

	def index
		@users = User.paginate( page: params[ :page ] )
	end

  def show
  
  	@user = User.find( params[:id] )
  	
  	@microposts = @user.microposts.paginate( page: params[:page] )
  
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
  
	def destroy
		user = User.find(params[:id])
		
		if current_user? user
			redirect_to( root_path )
		else
			user.destroy
			flash[:success] = "User destroyed."
			redirect_to users_url
		end
	end
  
	# 内部処理群
	private
  
		def user_params
			params.require( :user ).permit( :name, :email, :password, :password_confirmation )
		end
		
		# Before actions
		
#		def signed_in_user
#			# フレンドリーフォワーディング用に保持
#			store_location
#			
#			redirect_to signin_url, notice: "Please sign in." unless signed_in?
#		
#		end

		def correct_user
			@user = User.find(params[:id])

			redirect_to(root_path) unless current_user?(@user)
		end
		
	# adminじゃない場合はルート画面へ遷移
	def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
