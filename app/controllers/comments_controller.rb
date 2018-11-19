class CommentsController < ApplicationController
  def update
    cmt = Comment.find(params[:id])
    return unless cmt
    cmt.update!(content: params[:content])
  end
end
