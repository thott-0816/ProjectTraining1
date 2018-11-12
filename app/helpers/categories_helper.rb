module CategoriesHelper
  def sub(level)
    "#{'- ' * level}"
  end

  def options(array = [], parent_id = nil, level = 0)
    Category.roots(parent_id).each do |category|
      array << [sub(level) + category.name, category.id]
      options(array, category.id, level + 1)
    end
    array
  end

  def options_author
    User.can_post_course
  end
end
