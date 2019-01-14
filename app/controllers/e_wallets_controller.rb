class EWalletsController < ApplicationController
  def create
    if current_user.e_wallet.nil?
      e_wallet = current_user.build_e_wallet
      if e_wallet.save
        flash[:success] = t "create_success"
        redirect_to e_wallet_path e_wallet
      else
        flash[:danger] = t "create_failed"
        render :new
      end
    end
  end

  def show
    @e_wallet = current_user.e_wallet
    if params[:number].to_i > 0 
      @credit = Credit.find_by_number(params[:number])
      unless @credit
        flash[:danger] = t ".not_found"
        redirect_to e_wallet_path @e_wallet
      end
    end
    @credits = @e_wallet.credits  
  end
end
