module CoursesHelper
  def show_more_cmt comment
    html = ""
    for i in 1..(comment.comment_child?.count/Settings.per_page)
      html << "<span class='hidden block-child-#{i}'>"
      comment.block_cmt_child(i*Settings.per_page).each do |child_comment|
        html << (render "child_comment", child_comment: child_comment)
      end
      if comment.comment_child?.count > (i+1)*Settings.per_page
        html << "<p class='order-item show-block' data-block='#{i+1}'>"
          html << t("course.comment.show_more")
        html << "</p>"
      end
      html << "</span>"
    end
    html.html_safe
  end
end
