class UsersController < ApplicationController

  def index
    @user = current_user
    @users = User.all

  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.all

  end



  def create #追加？？？？？？

    book = Book.new(book_params)
    book.user_id = current_user.id
    book.save
    redirect_to books_path

  end




  def edit
    @user = User.find(params[:id])
  end
  

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else 
      render :edit
    end 
    

  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)

  end

end
