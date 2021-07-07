class PostCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    comment = current_user.post_comments.new(post_comment_params)
    # ↑ comment = PostComment.new(post_comment_params)
    #   comment.user_id = current_user.id. の省略
    comment.book_id = @book.id
    comment.save


  end



  def destroy
    @book = Book.find(params[:book_id])
    comment = @book.post_comments.find(params[:id])
    comment.destroy
    
  end
  
  

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)

  end

end
