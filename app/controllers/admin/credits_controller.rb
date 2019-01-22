class Admin::CreditsController < Admin::ApplicationController
  def update
    credit = Credit.find_by id: params[:id]
    if credit.present?
      if !credit.approved? && credit.update(approved_params)
        flash[:success] = t ".appro_success"
      elsif credit.approved? && credit.update(approved_connected_params)
        flash[:success] = t ".unappro_success"
      else
        flash[:danger] = t ".failure"
      end
    else
      flash[:alert] = t ".credit_nil"
    end
    redirect_to admin_credits_path
  end

  def index
    @credits = Credit.all
  end

  def show
  end

  private
  def approved_params
    params.require(:credit).permit :approved
  end

  def approved_connected_params
    params.require(:credit).permit :approved, :connected
  end

  def credit_params
    params.require(:credit).permit :e_wallet_id, :number, :bank, :card_type,
      :balances, :name, :gender, :date_of_birth, :address, :phone,
      :expiration_date, :email, :employed_by
  end 
end
