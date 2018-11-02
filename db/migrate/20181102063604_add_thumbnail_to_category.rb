class AddThumbnailToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :thumbnail, :string
  end
end
