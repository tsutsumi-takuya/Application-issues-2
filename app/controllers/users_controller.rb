class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :baria_user, only: [:edit, :update]

  def index
    @users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
    @book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])

    if @user.id == current_user.id
       render 'edit'
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    @books = @user.books

  end

  def create
    @user = User.new(name: params[:name], email: params[:email],image_name: "default_user.jpg",
      password: params[:password])

    if @user.save
      redirect_to user_path(@user.id), notice = "Welcome! You have signed up successfully."
    else
      redirect_to user_new_path
    end
  end

  # フォローしているユーザ
  def following
    @user  = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  # フォローされているユーザ
  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params)

    if @user.save
      redirect_to user_path(@user.id), notice: "successfully"
    else
      @users = User.all
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
    unless params[:id].to_i == current_user.id
      redirect_to user_path(current_user)
    end
   end

end
