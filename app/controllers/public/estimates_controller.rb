class Public::EstimatesController < ApplicationController
  def new
    @estimate = Estimate.new
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
  
  
  private
  
  def estimate_params
    params.require(:estimate).permit(:land_price, :grade, :floor_type, :tsubo, :building_price, :total_price)
  end
  

end
