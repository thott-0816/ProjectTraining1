class AddIndexToCourses < ActiveRecord::Migration[5.2]
  def change
    add_index :courses, [:description, :name], name: 'courses_description_name_full_text_search', type: :fulltext
    add_index :users, :name, name: 'users_name_full_text_search', type: :fulltext
  end
end
