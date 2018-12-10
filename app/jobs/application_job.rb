class ApplicationJob < ActiveJob::Base
  queue_as :default

  def perform course
    notifications = []
    content = "User #{}"
    course.user.followers.pluck(:id).each do |for_user_id|
      noti = {
        user_id: for_user_id,
        slug: course.slug,
        content: I18n.t("notification.create.content", name: course.user.name, course_name: course.name)
      }
      notifications << noti
    end
    Notification.create notifications
  end
end
