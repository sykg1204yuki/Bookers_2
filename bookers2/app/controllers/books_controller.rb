class BooksController < ApplicationController
  before_action :ensure_current_user, {only: [:edit, :update]}
  before_action :book_all

  def ensure_current_user
    book = Book.find(params[:id])
        if book.user != current_user
           redirect_to books_path
        end
  end

      # 通常は使わない！！！
        #attr_reader :books

        #def initialize()
          #@books = Book.all

        #end


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end

  end


  def index
    @user = current_user
    #@books = Book.all  private以下に記述
    #@book = Book.new

  end



  def show
    @book = Book.find(params[:id])
    @post_comment = PostComment.new
    @user = @book.user
    @new_book = Book.new

  end


  def edit
    @book = Book.find(params[:id])

  end


  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit

    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path

  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def book_all
    @books = Book.all
    @book = Book.new

  end


end
