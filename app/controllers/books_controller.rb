class BooksController < ApplicationController

before_action :authenticate_user!

  def index
    @books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(current_user.id)
    @book_new = Book.new
    @favorite = Favorite.new
    @book_comment = BookComment.new
    @book_comments = @book.book_comments
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id == current_user.id
        render 'edit'
    else
        redirect_to books_path
    end
  end

  def create
    @book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id
    if @book.save #入力されたデータをdbに保存する。
      redirect_to book_path(@book.id), notice: "successfully created book!"#保存された場合の移動先を指定。
    else
      @user = current_user
      @books = Book.all
      render 'index'
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      redirect_to book_path(@book.id), notice: "successfully updated book!"
    else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
      @user = current_user
      @books = Book.all
      render "edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

end
