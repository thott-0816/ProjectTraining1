class CreditsController < ApplicationController
  def update
    credit = Credit.find_by id: params[:id]
    if credit.present?
      if credit.e_wallet.present?
        flash[:alert] = t ".existed"
      elsif credit.update e_wallet_param
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".failure"
      end
      redirect_to e_wallet_path credit.e_wallet
    else
      flash[:alert] = t ".credit_nil"
      redirect_to e_wallet_path current_user.e_wallet
    end
  end
  
  private
  def e_wallet_param
    params.require(:credit).permit :e_wallet_id
  end
end
