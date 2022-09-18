class BookCommentsController < ApplicationController

  before_action :correct_user, only: [:destroy]

  def create
    @books = Book.find(params[:book_id])
    @comment = BookComment.new(book_comment_params)
    @comment.user_id = current_user.id
    @comment.book_id = @books.id
    @comment.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = BookComment.find(params[:id])
    @comment.destroy

  end

   private

  def book_comment_params
    params.require(:book_comment).permit(:user_id, :book_id, :comment)
  end

  def correct_user
    # コメントした本人＋ではないならリダイレクトさせるという表現がしたい
    @comment = BookComment.find(params[:id])

    if current_user.id != @comment.user.id
      redirect_to books_path
      # 正しいユーザーではない場合本一覧に戻す
    end
  end

end
