class AddSlugToTable < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :slug, :string
    add_column :courses, :slug, :string
    add_index :categories, :slug
    add_index :courses, :slug
  end
end
