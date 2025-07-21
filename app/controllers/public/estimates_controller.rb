class Public::EstimatesController < ApplicationController

  before_action :set_estimate, only: [:show, :destroy]

  def new
    @estimate = Estimate.new
    @tags = Tag.all
  end
  
  def create
    @estimate = current_user.estimates.build(estimate_params)
    if @estimate.save
      redirect_to estimates_path, notice: '見積もりを保存しました。'
    else
      render :new
    end
  end

  def index
    @estimates = current_user.estimates
  end

  def show
    @estimate = current_user.estimates.find_by(id: params[:id])
  end  
  
  def destroy
    @estimate.destroy
    redirect_to estimates_path, notice: '見積もりを削除しました。'
  end
  
  private
  
  def estimate_params
    params.require(:estimate).permit(:land_price, :grade, :floor_type, :tsubo, :building_price, :total_price)
  end

  def set_estimate
    @estimate = current_user.estimates.find_by(id: params[:id])
    unless @estimate
      redirect_to estimates_path, alert: '見積もりが見つかりませんでした。'
    end
  end

end

private

def estimate_params
  params.require(:estimate).permit(
    :land_price, :grade, :floor_type, :tsubo,
    :building_price, :total_price,
    tag_ids: []
  )
end
