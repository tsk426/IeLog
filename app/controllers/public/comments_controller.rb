class Public::CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_review

  def create
    @comment = @review.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to review_path(@review), notice: 'コメントを投稿しました。'
    else
      @comments = @review.comments.includes(:user)
      flash.now[:alert] = '空白のコメントは投稿できません。'
      render 'public/reviews/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to review_path(@comment.review), notice: 'コメントを削除しました。'
    else
      redirect_to review_path(@comment.review), alert: '削除権限がありません。'
    end
  end

  private

    def set_review
      @review = Review.find(params[:review_id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
  end

