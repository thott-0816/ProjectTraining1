class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def update
    cmt = Comment.find(params[:id])
    return unless cmt
    cmt.update!(content: params[:content])
  end
end
