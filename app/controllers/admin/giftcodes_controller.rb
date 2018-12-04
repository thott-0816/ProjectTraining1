class Admin::GiftcodesController < Admin::ApplicationController
  before_action :load_all_giftcode, only: :index

  def index; end

  private

  def load_all_giftcode
    @giftcode = Giftcode.list_all?
  end
end
