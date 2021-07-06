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
    PostComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_back(fallback_location: root_path)

  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)

  end

end
