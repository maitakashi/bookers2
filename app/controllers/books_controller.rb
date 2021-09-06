class BooksController < ApplicationController
  before_action :ensure_current_user, {only: [:edit, :update]}
def ensure_current_user
  @book = Book.find(params[:id])
  if current_user.id != @book.user_id
    flash[:notice]="権限がありません"
    redirect_to books_path
  end
end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @user = current_user
    @books = Book.all
    puts current_user
    @book.user_id = current_user.id
    if @book.save
       @user.save
        flash[:notice] = "you have created book successfully"
        redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def edit
    @books = Book.find(params[:id])
  end

  def show
    @Book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def update
    @books = Book.find(params[:id])
    if @books.update(book_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to book_path(@book.id)
    else
        render :edit
    end
  end

  def destroy
    @books = Book.find(params[:id])
    @books.destroy
    redirect_to books_path
  end

  private

  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end