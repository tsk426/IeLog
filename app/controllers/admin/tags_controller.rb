class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'
  before_action :set_tag, only: :destroy

  def index
    @tags = Tag.order(:id)       # お好みで :category, :name など
    @tag  = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path, notice: 'タグを追加しました'
    else
      @tags = Tag.order(:id)
      flash.now[:alert] = @tag.errors.full_messages.to_sentence
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy!
    redirect_to admin_tags_path, notice: 'タグを削除しました'
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :price, :category)
  end
end
