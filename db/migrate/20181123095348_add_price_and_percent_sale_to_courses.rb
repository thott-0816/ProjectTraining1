class AddPriceAndPercentSaleToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :price, :int
    add_column :courses, :percent_sale, :int
  end
end
