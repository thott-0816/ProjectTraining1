module ApplicationHelper
  def create_new_e_wallet
    if current_user.e_wallet.nil?
      @e_wallet = current_user.build_e_wallet
    else
      flash[:danger] = t "existed"
    end
  end
end
