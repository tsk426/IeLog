class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @tags = ActsAsTaggableOn::Tag.all
    @tag = ActsAsTaggableOn::Tag.new
  end

  def create
    ActsAsTaggableOn::Tag.create(name: params[:acts_as_taggable_on_tag][:name])
    redirect_to admin_tags_path, notice: "タグを追加しました"
  end

  def destroy
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @tag.destroy
    redirect_to admin_tags_path, notice: "タグを削除しました"
  end
end