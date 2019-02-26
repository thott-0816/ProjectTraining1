class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = current_user.e_wallet.transactions.build transaction_params
    if @transaction.save
      redirect_to e_wallet_path @transaction.e_wallet
      flash[:success] = t "create_success"
    end
  end
  
  private
  def transaction_params
    params.require(:transaction).permit :credit_id, :e_wallet_id, :amount,
    :confirmation_code, :code_status, :transaction_status, :content
  end
end
