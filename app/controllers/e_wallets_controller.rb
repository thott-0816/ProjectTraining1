class EWalletsController < ApplicationController
  def create
    if current_user.e_wallet.nil?
      e_wallet = current_user.build_e_wallet
      if e_wallet.save
        flash[:success] = t "create_success"
        redirect_to e_wallet_path e_wallet
      else
        flash[:danger] = t "create_failed"
      end
    end
  end

  def show
    @e_wallet = EWallet.find_by id: params[:id]
    @approved_credits = @e_wallet.credits.approved
    if params[:number]
      @credit = Credit.find_by id: params[:number]
    end
  end
end
